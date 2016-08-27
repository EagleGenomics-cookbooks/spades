
# Check that Spades executable is in the path
describe command('which spades.py') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match('spades') }
end

# Check that spades version matches
describe command('spades.py --version') do
  its('exit_status') { should eq 0 }
  its('stderr') { should match('SPAdes v3.9.0') }
end

# Check that spades works - spades comes with a test data set!
describe command('spades.py --test') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match('TEST PASSED CORRECTLY') }
end
