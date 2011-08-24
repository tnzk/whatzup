require 'waz-blobs'

cred = {
  'production' => 
    { name: 'your account name',
       key: 'your secret' },
  'development' =>
    { name: 'your account name',
       key: 'your secret'}
}[RAILS_ENV]

WAZ::Storage::Base.establish_connection!(:account_name => cred[:name], :access_key => cred[:key])

container_name = 'whatzup'
cont = WAZ::Blobs::Container.find( container_name)
cont = WAZ::Blobs::Container.create( container_name) if cont.nil?
# cont.public_access = WAZ::Blobs::BlobSecurity::Container

# workaround
cont.class.service_instance.execute :put, container_name, { :restype => 'container', :comp => 'acl' }, { :x_ms_blob_public_access => 'container', :x_ms_version => '2009-09-19' }


Whatzup::Application.config.container = cont
Whatzup::Application.config.credential = cred
