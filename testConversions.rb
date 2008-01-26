#
#  testConversions.rb
#  RunRubyScriptAction
#
#  Created by Jason Foreman on 1/25/08.
#  Copyright (c) 2008 __MyCompanyName__. All rights reserved.
#

require 'test/unit'

require 'osx/cocoa'
include OSX

require_framework "ScriptingBridge"
require_framework "Automator"

# the thing under test
require 'RunRubyScriptAction'

class TC_testConversions < Test::Unit::TestCase
	def setup
		@action = RunRubyScriptAction.alloc().init().retain()
		@ab = SBApplication.applicationWithBundleIdentifier 'com.apple.AddressBook'
	end

	def teardown
		@action.release()
	end

	def testSingleInput
		input = @ab.people.
	end

end
