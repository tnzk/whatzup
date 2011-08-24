class Asset < ActiveRecord::Base
  def store(data)
    mime = MimeMagic.by_path(name).to_s
    mime = 'application/octet-stream' if mime == ''
    cont.store( _blob_name, data, mime)
  end

  def public?
    password2download == ''
  end

  def size_mb
    (storage_size.to_f / 1000.0).ceil / 1000.0
  end

  def url
    "http://#{cred[:name]}.blob.core.windows.net/#{cont.name}/#{_blob_name}"
  end

  def _blob_name
    _blob_base + File::extname(name)
  end

  def _blob_base
    Digest::SHA256.hexdigest("%kvos)sfsdfs:^*#{name}njc#{password2delete}")
  end

  def blob
    cont[_blob_name]
  end

  def cont
    Whatzup::Application.config.container
  end

  def cred
    Whatzup::Application.config.credential
  end
end
