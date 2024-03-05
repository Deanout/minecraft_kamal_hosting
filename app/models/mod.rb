class Mod < ApplicationRecord
  has_one_attached :zip, dependent: :destroy
  has_rich_text :description
  after_update :rename_zip_if_needed

  private

  def rename_zip_if_needed
    original_filename = zip.blob.filename.to_s if zip.attached?
    if saved_change_to_attribute?(:desired_attribute)
        RenameActiveStorageAttachmentJob.perform_later(self, 'avatar', "original_filename")
    end
  end
end
