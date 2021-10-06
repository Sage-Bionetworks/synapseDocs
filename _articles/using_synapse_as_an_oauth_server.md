---
title: "Using Synapse as an OAuth 2.0 Server"
layout: article
excerpt: Follow these steps to register an OAuth Client and authorize access to Synapse.
category: admin-and-settings
---

<style>
#image {
    width: 100%;
}
#imageSmall {
    width: 40%;
}
</style>

External web applications can now log in to Synapse and access users' identity and resources, with their consent and with a select, limited scope.  This is accomplished using a secure and industry-standard protocol called [OpenID Connect (OIDC)](https://openid.net/specs/openid-connect-core-1_0.html), which is an extension of OAuth 2.0.

## Registering and linking an OAuth 2.0 Client
The details of the Synapse Open ID Connect implementation are published on the web in a standard Open ID Configuration document (aka the "discovery document"): [https://repo-prod.prod.sagebase.org/auth/v1/.well-known/openid-configuration](https://repo-prod.prod.sagebase.org/auth/v1/.well-known/openid-configuration).  The document includes the web endpoints for registration, authorization, and token generation, as well as the scope of resources that can be requested, and the formats in which Synapse will return information.

All the OAuth clients in Synapse need to be verified after creation and before usage: if a unverified client is used to perform requests Synapse will prevent their execution replying with a [HTTP 403 Forbidden](https://en.wikipedia.org/wiki/HTTP_403) response.

In order to verify an OAuth client please contact <synapseinfo@sagebase.org> detailing:

- Your name
- The id of the client to be verified (See below on how to obtain the client id)
- A description of your application

## Create an OAuth 2.0 Client
An external application can be registered with Synapse as a "client" application by following the steps below.   The API reference documents for what follows are [here](https://rest-docs.synapse.org/rest/#org.sagebionetworks.auth.OpenIDConnectController), and the following instructions show how to invoke them from Python:


##### Python

```python
import synapseclient
import json
syn = synapseclient.login()

client_meta_data = {
  'client_name': 'Your client name',
  'redirect_uris': [
    'https://yourhost.com/user/login'
  ],
  'client_uri': 'https://yourhost.com/index.html',
  'policy_uri': 'https://yourhost.com/policy',
  'tos_uri': 'https://yourhost.com/terms_of_service',
  'userinfo_signed_response_alg': 'RS256'
}

# Create the client:
client_meta_data = syn.restPOST(uri='/oauth2/client', 
	endpoint=syn.authEndpoint, body=json.dumps(client_meta_data))

client_id = client_meta_data['client_id']

# Generate and retrieve the client secret:
client_id_and_secret = syn.restPOST(uri='/oauth2/client/secret/'+client_id, 
	endpoint=syn.authEndpoint, body='')

print(client_id_and_secret)
```

##### R

```r
library(synapser)
library(rjson)
synLogin()

client_meta_data <- list(
  client_name='Your client name',
  redirect_uris= list(
    'https://yourhost.com/user/login'
  ),
  client_uri='https://yourhost.com/index.html',
  policy_uri='https://yourhost.com/policy',
  tos_uri='https://yourhost.com/terms_of_service',
  userinfo_signed_response_alg='RS256'
)

# Create the client:
client_meta_data<-synRestPOST('/oauth2/client', toJSON(client_meta_data), 
  'https://repo-prod.prod.sagebase.org/auth/v1')

client_id <-  client_meta_data$client_id

# Generate and retrieve the client secret:
client_id_and_secret<-synRestPOST(paste0('/oauth2/client/secret/',client_id), 
  '', 'https://repo-prod.prod.sagebase.org/auth/v1')

print(client_id_and_secret)
```

The client URI, policy URI, and terms of service URI are optional, as is the `userinfo_signed_response_alg` parameter. You can optionally include a `sector_identifier_uri` parameter, an advanced feature described [here](https://openid.net/specs/openid-connect-registration-1_0.html#SectorIdentifierValidation), relevant if the client uses multiple hosts since Synapse only returns `pairwise` subject values to its OAuth clients.


The returned `client_id` and `client_secret` will be needed later when getting an access token. The secret is only returned once. (It is not stored in Synapse.)  If lost, you can generate a new secret but the previous one will be invalidated.

You can retrieve, update, and delete your client programmatically using the following commands:

##### Python

```python
# Retrieve a client using its ID:
client_meta_data = syn.restGET(uri='/oauth2/client/'+client_id, 
	endpoint=syn.authEndpoint)

client_meta_data['policy_uri'] = 'https://yourhost.com/updated_policy'

# Update a client's metadata:
client_meta_data = syn.restPUT(uri='/oauth2/client/'+client_id, 
	endpoint=syn.authEndpoint, body=json.dumps(client_meta_data))

# Delete a client:
syn.restDELETE(uri='/oauth2/client/'+client_id, endpoint=syn.authEndpoint)

```

##### R

```r
# Retrieve a client using its ID:
client_meta_data <- synRestGET(paste0('/oauth2/client/',client_id), 
	'https://repo-prod.prod.sagebase.org/auth/v1')

client_meta_data$policy_uri <- 'https://yourhost.com/updated_policy'

# Update a client's metadata:
client_meta_data <- synRestPUT(paste0('/oauth2/client/',client_id), 
	toJSON(client_meta_data), 'https://repo-prod.prod.sagebase.org/auth/v1')

# Delete a client:
synRestDELETE(paste0('/oauth2/client/',client_id), 
	'https://repo-prod.prod.sagebase.org/auth/v1')

```

## Authenticating with Synapse

To login via Synapse your client application should redirect the browser from your application to `https://signin.synapse.org`, with the standard OAuth 2.0 request parameters:

- `client_id`=`<your client id>`
- `scope`=`<space-separated list of scopes`>
- `redirect_uri`=`<the redirect uri registered with your client>`
- `response_type`=`code`
- `state`=`<any state you want returned>`
- `nonce`=`<some string to be returned in the ID token>`
- `claims`=`<a JSON object>`

As per the OpenID Connect specification, `scope` is a space-separated list of scopes, and it must include the scope `openid` in order for the client to receive user identity information.  To receive a refresh token the scope `offline_access` must be included. The complete list of available scopes is given [here](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/oauth/OAuthScope.html).

Synapse supports the `claims` request parameter, a JSON document containing the details of the user identity information you would like returned, as described [here](https://openid.net/specs/openid-connect-core-1_0.html#ClaimsParameter). The list of supported claims is given [here](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/oauth/OIDCClaimName.html). For most claims the value to include in the JSON document is `null`. The exception is the `team` claim, for which you provide the IDs of one or more teams, the membership of which you wish to inquire about. Synapse will return the IDs of the subset of the given list of teams to which the user belongs. Here is an example of a claims parameter JSON object:

```
 {
   "id_token":
    {
     "given_name": null,
     "family_name": null,
     "is_certified": null,
     "team": {"values":["273957", "3385814"]}
    },
   "userinfo":
    {
     "given_name": null,
     "family_name": null,
     "is_certified": null,
     "team": {"values":["273957", "3385814"]}
    }
  }
```

Following the user's consent, Synapse will redirect back to your specified redirect URI with an authorization code and your 'state' data. You can then exchange the authorization code for a ID token and access token in the standard way. Here is an example using `curl`:

```
curl -H "Authorization:Basic XXXXXXXXXXX" -X POST "https://repo-prod.prod.sagebase.org/auth/v1/oauth2/token?grant_type=authorization_code&redirect_uri=<redirect URI>&code=<authorization code>

```
where `<redirect URI>` is as before and `<authorization code>` is the value returned to your application by Synapse. The request is authorized using the `client_id` and `client_secret` provided by Synapse, encoded in the header in the standard way: joined with a ':' separator and base 64 encoded. Synapse responds with an ID Token, an access token and (if `offline_access` was a specified scope) a refresh token:


```
{
  "id_token": ...,
  "access_token": ...,
  "refresh_token": ...
}
```

The ID token is a signed JSON Web Token. The public key(s) used to verify the token signatures are available at the JSON Web Key Set (jwks) URL listed in the OpenID Configuration document. The ID Token contains the requested user identity information. The access token can be used to authorize future requests. 


## Making Authorized Requsts

Access tokens authorize requests to Synapse services.  For example, to get an entity's metadata:

```
curl -H "Authorization:Bearer <access token>" https://repo-prod.prod.sagebase.org/repo/v1/entity/syn123456

```

where <access token> is the value returned from the token endpoint and `syn123456` is replaced with the ID of the entity of interest.  As with all available services, [this service](https://rest-docs.synapse.org/rest/GET/entity/id.html) is defined in the Synapse [REST documents](https://rest-docs.synapse.org/rest).  The page for each service requiring authorization lists the "Required OAuth Scopes" for the service, i.e., the scope(s) that the access token must have in order to access the service.  In this example the required scope is `view`.

One service specifically defined by OpenID Connect is the `userinfo` service.  To get an updated ID Token using the access token as authorization, send a request to the `userinfo` endpoint:

```
curl -H "Authorization:Bearer <access token>" https://repo-prod.prod.sagebase.org/auth/v1/oauth2/userinfo

```

If the `'userinfo_signed_response_alg': 'RS256'` option was included in the client registration then the result will be returned as a signed JSON Web Token, otherwise a simple JSON object will be returned.

To make authenticated requests with the Synapse client:

In Python:

```python
import synapseclient
syn = synapseclient.Synapse()
syn.login(authToken=<access token>)
```

In R:

```python
library(synapser)
synLogin(authToken=<access token>)
```

## Refresh Tokens

Access tokens last for 24 hours, after which the client must either repeat the authorization process or use the refresh token to get a new access token.  To do the latter, send a request to the refresh token endpoint: 

```
curl -H "Authorization:Basic XXXXXXXXXXX" -X POST "https://repo-prod.prod.sagebase.org/auth/v1/oauth2/token?grant_type=refresh_token&refresh_token=<refresh_token>"

```

Synapse supports an optional `scope` parameter which is a _down selected_ list of scopes, reducing the scope of the new access token.  The response includes a new refresh token, the previous one being rendered obsolete.  Refresh tokens expire 180 days after their last use.  As long as a refresh token continues to be used it will not expire.  If a refresh token expires the client can get a new one simply by asking the user to login again.

The client may revoke a refresh token and the associated active access token (if any).  This is a request to the revocation endpoint:

```
curl -H Content-Type:application/json -d "{\"token\":\"<refresh token>\",\"token_type_hint\":\"refresh_token\"}" -X POST "https://repo-prod.prod.sagebase.org/auth/v1/oauth2/revoke"

```

If using the access token in the aforementioned request, change `token_type_hint` to `access_token`.  

The services described here allow an OAuth client to manage tokens. A separate set of services allow the _user_ to review and revoke refresh tokens that they have granted to an OAuth client.  The details are given [here](https://rest-docs.synapse.org/rest/#org.sagebionetworks.auth.controller.OpenIDConnectController).




