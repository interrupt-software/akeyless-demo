# akeyless-demo

## Authenticate using a static role
```
akeyless auth
Access Id: p-abcdefghi9jk
Access Key: 
Authentication succeeded.
Token: t-12345a67bc8901defa23b45cd6e78f9a
```

## Retrieve a static secret
```
akeyless get-secret-value \
--name /trendy-tabby/trendy-tabby-secret-recipe
```
We expect the following on the screen
```
Fresh Whole Chicken
Cod-liver Oil
Coconut Oil
Turmeric
Vitamin E Supplement
Inulin
```
