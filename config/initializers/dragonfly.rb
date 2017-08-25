require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  # if Rails.env.production?
  #   require 'dragonfly/s3_data_store'

  #   aws_credentials = BestAwsCredentials.new.resolve

  #   s3_options = {
  #     bucket_name: Rails.configuration.x.uploads.s3_bucket,
  #     storage_headers: {'x-amz-acl' => 'public-read'},
  #     url_scheme: 'https',
  #     region: Rails.configuration.x.aws.region,
  #   }

  #   if aws_credentials.is_a?(Aws::InstanceProfileCredentials)
  #     s3_options[:use_iam_profile] = true
  #   else
  #     aws_credentials = aws_credentials.credentials
  #     s3_options[:access_key_id] = aws_credentials.access_key_id
  #     s3_options[:secret_access_key] = aws_credentials.secret_access_key
  #   end

  #   datastore :s3, **s3_options
  # else
  path = Rails.root.join("public", "uploads", Rails.env)

  if Rails.env.test?
    path.rmtree if path.exist?
  end

  path.mkpath unless path.exist?

  file_options = {
    root_path: path.to_s,
    server_root: path.dirname.dirname.to_s,
  }

  datastore :file, file_options
  # end
end

# Logger
Dragonfly.logger = Rails.logger

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
