# yaml
humam readable via line separation and spacing. make sure use validation too

## Key value pairs
# comment here
app: user-authentication
name: "this is a string"
microservice:
  port: 9000
  name: dbreader
  version: 1.7

## Key Value Pair
```yaml
microservice:
  - app: user-authentication
    port: 9000
    version: 1.7
  - app: shopping-cart
    port: 9001
    version: 1.9
```

## array
```yaml
version: [1.7, 1.9, 2.0]
```

## multiline string
```yaml
multilineString: |
  this is a
  multiline string
multilineString2: "this is a /n multiline string"
```