# Simple Blueprint and Environment example

This is a simple all-in-one, environment, blueprint, config and TF files, example to demonstrate the capabilites of IBM Cloud Schematics Blueprints to deploy a simple 2 component solution stack. It does not require a Cloud APIKey and assumes the users IAM credentials. It will take about 10 minutes to install and delete. 

Following types of resources are deployed:
- Resource Group
- COS instance and bucket


The blueprint is comprised of two  linked components to deploy the resource group and COS resources. These create the Schematics Workspaces
- basic2comp-resource-group
- basic2comp-cos-storage

The blueprint demonstrates passing of the resource_group_id variable from the basic2comp-resource-group component to the basic2comp-cos-storage component. 

The logical structure and file naming of this example is illustrated below. All definitions and Terraform code are included within this one repo. This allows for easy modification of this example without impact on other Blueprints users. 

```
basic2comp-env-us.yaml                       (environment)
├── basic2comp-config-us.yaml                (config)
└── basic2comp-blueprint.yaml                (blueprint)
     ├── basic2comp-resource-group
     |    └── IBM-ResourceGroup              (Terraform)
     └── basic2comp-cos-storage
          └── IBM-Storage                    (Terraform)
```

## Environment Inputs
| Name | Type | Value | Description |
|------|------|------|----------------|
| name | string | Simple Blueprint Environment | |
| location| string | us-east | Schematics instance region |
| resource_group | string | Default | Schematics Resource group |



## Config Inputs

| Name | Type | Value | Description |
|------|------|------|----------------|
| region | string | us-east | Resource deployment region |
| resource_group_name | string | basic2comp-us | Resource group to create |
| provision_rg | string | true | Create RG - true. Use existing RG - false |
| cos_instance_name | string | basic2comp-cos | Name for COS instance |



## Usage 
This example is intended for usage as is, using the latest git release tgz file. It is assumed the Resource Group `Default` exists for Schematics IAM access control. 

```
$ ibmcloud schematics environment external -repo-url https://github.ibm.com/schematics-solution/environment-aio-iks-app-us/releases/download/v1.0.3/environment-aio-iks-app-us-1.0.3.tgz -env-file iks-app-env-us.yaml

$ ibmcloud schematics environment create

$ ibmcloud schematics job run -rt env -n init -id environment_id

$ ibmcloud schematics job run -rt env -n install -id environment_id

$ ibmcloud schematics job run -rt env -n destroy -id environment_id

$ ibmcloud schematics job run -rt env -n delete -id environment_id
```
## Forking and modifying the example
This example can be forked to a personal repo and modified. Follow the instructions in the Blueprints wiki for [Modifying the Sample App](https://github.ibm.com/schematics-solution/schematics-blueprints/wiki/5.4-Tutorial-Modifying-the-Environment-Examples)

