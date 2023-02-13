
## Registry
**Create**
```powershell
New-AzContainerRegistry `
  -Name YOUR_CONTAINER_REGISTRY_NAME `
  -Sku Basic `
  -Location NorthCentralUS
```

**List**
```powershell
Get-AzContainerRegistryRepository -RegistryName YOUR_CONTAINER_REGISTRY_NAME
```

**Publish**
```sh
az bicep publish \
   --file module.bicep \
   --target 'br:toycompany.azurecr.io/mymodules/modulename:moduleversion'
```
Target contains four segments:
- *Scheme:* Bicep supports several module types, which are called schemes. When you work with Bicep registries, the scheme is `br`.
- *Registry:* This is the name of the registry that contains the module you want to use. In the preceding example, the registry name is `toycompany.azurecr.io`, which is the name of the container registry.
- *Module identifier:* This is the full path to the module within the registry. `mymodules/modulename`
- *Tag:* Tags typically represent versions of modules, because a single module can have multiple versions published. You'll learn more about tags and versions shortly. `moduleversion`

Versioning schemes
Your versioning scheme determines how you generate version numbers. Common versioning schemes include:

- *Basic integers* can be used as version numbers. For example, your first version might be called 1, your second version 2, and so forth. Or, you might add a prefix to each version number, such as `v1` and `v2`.
- *Dates* also make good version numbers. For example, if you publish the first version of your module on January 16, 2022, you might name the version `2022-01-16` (using yyyy-mm-dd format). When you publish another version on March 3, you could name it `2022-03-03`.
- *Semantic versioning* is a versioning system often used in software, where a single version number contains multiple parts. Each part signals different information about the nature of the change.

## Use
Bicep Module
```bicep
module myModule 'br:myregistry.azurecr.io/modulepath/modulename:moduleversion' = {
  name: 'my-module'
  params: {
    moduleParameter1: 'value'
  }
}
```

Alias - `bicepconfig.json` file in the same folder as your Bicep file
Ex 1
```json
{
  "moduleAliases": {
    "br": {
      "MyRegistry": {
        "registry": "myregistry.azurecr.io"
      }
    }
  }
}
```

```bicep
module myModule 'br/MyRegistry:bicep/my-module:v1' = {
  // ...
}
```

Ex 2
```json
{
  "moduleAliases": {
    "br": {
      "MyRegistryWithPath": {
        "registry": "myregistry.azurecr.io",
        "modulePath": "bicep"
      }
    }
  }
}
```

```bicep
module myModule 'br/MyRegistryWithPath:my-module:v1' = {
  // ...
}
```

