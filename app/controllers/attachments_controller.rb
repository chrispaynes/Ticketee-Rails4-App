class AttachmentsController < ApplicationController

  # displays the attachment 
  # instructs browser to render or download attachment
  def show
    attachment = Attachment.find(params[:id])
    authorize attachment, :show?
    send_file attachment.file.path, disposition: :inline
  end
end

