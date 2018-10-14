# frozen_string_literal: true

require 'grape'

require 'grape-swagger/errors'
require 'grape-swagger/openapi_3/endpoint'
require 'grape-swagger/openapi_3/doc_methods'

require 'grape-swagger/model_parsers'

module GrapeSwagger
  class << self
    def model_parsers
      @model_parsers ||= GrapeSwagger::ModelParsers.new
    end
  end
  autoload :Rake, 'grape-swagger/rake/oapi_tasks'
end

module Grape
  class OpenApi
    def add_swagger_documentation(options = {})
      documentation_class = create_documentation_class
      documentation_class.setup(options)
      documentation_class
    end

    private

    def create_documentation_class
      Class.new(Grape::API) do
        extend GrapeOpenAPI::DocMethods
      end
    end
  end
end
