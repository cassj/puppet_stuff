module Puppet
  newtype(:sysctl) do
     @doc = "Sets a kernel parameter"
     newparam(:name) do
       desc "The name of the resource"
     end
     newparam(:param) do
       desc "The name of the kernel parameter (defaults to $name)"
     end
     newparam(:value) do
       desc "The value of the kernel parameter"
     end

     newproperty(:ensure) do
       desc "Whether the parameter should be 'present' (default) or 'absent'"

       # this is the should-be value of the property (ie. ensure => present)
       defaultto :insync
       
       def retrieve
         # This returns what the value of the property actually *is*
         # should be outofsync if parameter doesn't exist, or exists with wrong value.
         File.readlines(resource[:file]).map { |l|
             l.chomp
         }.include?(resource[:line]) ? :insync : :outofsync
       end 
     end
   
  end
end
