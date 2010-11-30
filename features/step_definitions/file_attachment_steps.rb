Given /^the following file attachments:$/ do |file_attachments|
  FileAttachment.create!(clients.hashes)
end

