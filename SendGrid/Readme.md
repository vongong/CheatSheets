# Send Grid

## Setup via Azure MarketPlace
- Go to MarketPlace
- Search Twilio SendGrid
- Fill Form and Subscribe
- After completed
- Go to Azure Portal and search [name of SendGrid]
- Click on Open SaaS Account in Publisher's site.

## Integrating with SendGrid
- [link](https://docs.sendgrid.com/for-developers/sending-email/integrating-with-the-smtp-api)
- Create an API Key with at least "Mail" permissions.
  - smtp.sendgrid.net
  - username: apikey
  - password: API key generated
- Set the port to 587 (or as specified below).
  - SMTP ports
  - For an unencrypted or a TLS connection, use port 25, 2525, or 587.
  - For a SSL connection, use port 465.

## Curl Exmaple
-- [link](https://docs.sendgrid.com/for-developers/sending-email/curl-examples)
```sh
curl --request POST \
  --url https://api.sendgrid.com/v3/mail/send \
  --header 'Authorization: Bearer YOUR_API_KEY' \
  --header 'Content-Type: application/json' \
  --data '{"personalizations": [{"to": [{"email": "vongong@gmail.com"}]}],"from": {"email": "vgong@batteriesplus.com"},"subject": "Hello, World!","content": [{"type": "text/plain", "value": "Heya!"}]}'
```