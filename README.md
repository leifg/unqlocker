# UNQLOCKER

DISCLAIMER: I am in no way associated with the ransomware group that developed QLocker. I am not able to assist you with retrieving the password to your encrypted files.

If you've been a victim of the ransomware [QLocker](https://www.bleepingcomputer.com/news/security/qnap-warns-of-agelocker-ransomware-attacks-on-nas-devices/) you most likely have a lot of encrypted files.

You will need to acquire the password to decrypt all these files. I can't help you with that. If you do however retrieve the password you are challenged with the task of going through all the files and decrypt one by one.

This script helps you with decrypting all files in directories recursively. YOU WILL NEED THE PASSWORD!

Features:
- Decrypt all files within a folder recursively
- Skip files that are already decrypted (everything that doesn't end in .7z)
- Output files into a different folder (original files remain)
- Never overwrite existing files

Careful:

This script does not delete the original files, so make sure you have enough space in your output_path available. The output path cannot be contained in the input path.

```ruby
ruby unqlocker.rb --input=<input_path> --output=<output_path> --password=<password>
```
