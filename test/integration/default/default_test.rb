# # encoding: utf-8

# Inspec test for recipe acrobat_pro::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

return unless os.windows?

acrobat_path = if file('C:\Program Files (x86)\Adobe\Acrobat DC\Acrobat').exist?
                 'C:\Program Files (x86)\Adobe\Acrobat DC\Acrobat'
               else
                 'C:\Program Files (x86)\Adobe\Acrobat 2015\Acrobat'
               end

describe file("#{acrobat_path}\\Acrobat.exe") do
  it { should exist }
end

describe file("#{acrobat_path}\\acrodist.exe") do
  it { should exist }
end
