"use strict"

app = angular.module('cloudStorm.resourceService', [])

####################################################################################################

app.factory 'ResourceService', ['$injector', ($injector) ->


  ##################################################################################################
  camelCase = do ->
    DEFAULT_REGEX = /[-_]+(.)?/g

    toUpper = (match, group1) ->
      if group1 then group1.toUpperCase() else ''

    return (str, delimiters) ->
      str.replace(DEFAULT_REGEX, toUpper)

  ##################################################################################################

  resources    = {}
  lookup_table = {}

  ##################################################################################################

  class ResourceService

    register: (name, resource) ->
      resources[name] = resource

    register_dynamic_name = (name, service_name) ->
      lookup_table[name] = service_name

    get: (name) ->
      resource = resources[name]

      unless resource
        moduleName = lookup_table[name] || "#{camelCase(name)}Resource"
        try resource = $injector.get(moduleName)
        catch e;

        if resource
          @register(name, resource)
        else
          throw "CS-001: cannot auto-inject #{name}"

      return resource

  ##################################################################################################

  return new ResourceService
]
