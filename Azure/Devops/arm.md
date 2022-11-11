
# Parameter

## Array
### parameter declaration:
```json
{
    "customEmails": {
        "type": "array",
    "metadata": {
        "description": "alert email addressess"
        }
    }
}
```
###  in the parameters file:
```json
"customEmails": {
      "value": [
        "email1@domain.com",
        "email2@domain.com"     
      ]
    }
```
### usage:
```json
{ "customEmails": "[parameters('customEmails')]" }
```

# Functions
Arm functions (https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/template-functions)
  - bool(arg1) - Converts the parameter to a boolean.
  - subscription().subscriptionId
  - resourceGroup().name
  - int(valueToConvert) - Converts the specified value to an integer.
  - format(formatString, arg1, arg2, ...) - Creates a formatted string from input values.

### String Formatting
```json
{

    "Example1": "concat('/subscriptions/', subscription().subscriptionId, '/resourceGroups/', resourceGroup().name,'/providers/Microsoft.Web/serverFarms/',parameters('asp_name'))",
    "Example2": "[format('/subscriptions/{0}/resourceGroups/{1}/providers/Microsoft.Web/serverFarms/{2}', subscription().subscriptionId, resourceGroup().name,parameters('asp_name'))]",
    "Example3": "[esourceId('Microsoft.Web/serverfarms', parameters('asp_name'))]"
}
```

# Select from Map
```json
"parameters": {        
    "location": {
        "type": "string",
        "allowedValues": ["north", "south"]
    },
    "env": {
        "type": "string",
        "allowedValues": ["dev", "test"]
    }
},
"variables": {
    "envLoc": "[concat(parameters('env'),parameters('location'))]",
    "map": {
        "devnorth": {
            "fruit": "apple"
        },
        "devsouth": {
            "fruit": "orange"
        },
        "testnorth": {
            "fruit": "tomato"
        },
        "testsouth": {
            "fruit": "watermelon"
        }
    },
    "fruit": "[variables('map')[variables('envLoc')].fruit]"
},
"resources": [],
"outputs": {
    "outFruit": {
        "type": "string",
        "value": "[variables('fruit')]"
    }
}
```