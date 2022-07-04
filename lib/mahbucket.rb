require "mahbucket/engine"


Gem.loaded_specs['mahbucket'].dependencies.each do |d|
  require d.name
end

module Mahbucket

  class Configuration
    attr_accessor :authorize_request, :s3_credentials
  end

  class << self
    attr_reader :config

    def setup
      @config = Configuration.new
      yield config
      load_paperclip
    end
  
    def load_paperclip
      Paperclip::Attachment.default_options[ :storage        ] = :s3
      Paperclip::Attachment.default_options[ :url            ] = ':s3_alias_url'
      Paperclip::Attachment.default_options[ :path           ] = '/:class/:attachment/:id_partition/:style/:filename'
      Paperclip::Attachment.default_options[ :s3_protocol    ] = 'https'
      Paperclip::Attachment.default_options[ :s3_permissions ] = 'public-read'
      Paperclip::Attachment.default_options[ :s3_region      ] = @config.s3_credentials[:region]
      Paperclip::Attachment.default_options[ :s3_headers     ] = { 'Cache-Control' => 'max-age=315576000', 'Expires' => 10.years.from_now.httpdate }
      Paperclip::Attachment.default_options[ :s3_credentials ] = @config.s3_credentials
      Paperclip::Attachment.default_options[ :s3_host_alias  ] = "#{@config.s3_credentials[:bucket]}.s3.#{@config.s3_credentials[:region]}.amazonaws.com"
    end 
  end
end
