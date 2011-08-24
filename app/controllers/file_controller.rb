class FileController < ApplicationController
  def gen_password(s)
    Digest::SHA256.hexdigest(s + Whatzup::Application.config.secret_token)
  end

  def create
    tmp_file = params[:file]
    if tmp_file.nil?
      flash[:notice] = 'No file given'
      redirect_to '/' and return
    end
    if tmp_file.size > 25000000
      flash[:notice] = 'Too large file'
      redirect_to '/' and return
    end
    password2delete = gen_password(params[:password2delete])
    password2download = params[:password2download] != '' ? gen_password(params[:password2download]) : ''
    name = tmp_file.original_filename
    author = params[:author]

    asset = Asset.create(:name => name,
                         :password2delete => password2delete,
                         :password2download => password2download,
                         :comment => params[:comment],
                         :storage_size => tmp_file.size,
                         :viewed => 0, :downloaded => 0)
    asset.store(tmp_file.read)
    redirect_to '/'
  end

  def show
    @asset = Asset.find(params[:id])
    @asset.viewed += 1
    @asset.save
    @title = @asset.name
  end

  def download
    @asset = Asset.find(params[:id])
    if @asset.password2download != ''
      flash[:notice] = 'Password not given'
      redirect_to '/'
    else
      @asset.downloaded += 1
      @asset.save
      redirect_to @asset.url
    end
  end

  def private_download
    @asset = Asset.find(params[:id])
    @asset.downloaded += 1
    @asset.save

    if @asset.password2download != gen_password(params[:password])
      flash[:notice] = 'Incorrect password'
      redirect_to '/'
    else
      redirect_to @asset.url
    end
  end

  def delete
    @asset = Asset.find(params[:id])
    if @asset.password2delete == gen_password(params[:password])
      @asset.blob.destroy! if @asset.blob
      @asset.destroy
      flash[:notice] = 'Removed'
    else
      flash[:notice] = 'Incorrect password'
    end
    redirect_to '/'
  end

end
