class RenameVimeoFieldsInMediaResources < ActiveRecord::Migration
  def self.up
    rename_column :media_resources, :vimeo_url                , :video_url
    rename_column :media_resources, :vimeo_embed_html         , :video_embed_html
    rename_column :media_resources, :vimeo_thumb_file_name    , :video_thumb_file_name
    rename_column :media_resources, :vimeo_thumb_content_type , :video_thumb_content_type
    rename_column :media_resources, :vimeo_thumb_file_size    , :video_thumb_file_size
    rename_column :media_resources, :vimeo_thumb_updated_at   , :video_thumb_updated_at
  end

  def self.down
    rename_column :media_resources, :video_url                , :vimeo_url
    rename_column :media_resources, :video_embed_html         , :vimeo_embed_html
    rename_column :media_resources, :video_thumb_file_name    , :vimeo_thumb_file_name
    rename_column :media_resources, :video_thumb_content_type , :vimeo_thumb_content_type
    rename_column :media_resources, :video_thumb_file_size    , :vimeo_thumb_file_size
    rename_column :media_resources, :video_thumb_updated_at   , :vimeo_thumb_updated_at
  end
end
