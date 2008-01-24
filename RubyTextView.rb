#
#  RubyTextView.rb
#  RubyScriptAction
#
#  Created by Jason Foreman on 1/5/08.
#  Copyright (c) 2008 Jason Foreman. All rights reserved.
#

require 'osx/cocoa'
require 'irb' # gives us RubyLex
require 'stringio' # needed for RubyLex

include OSX

class RubyTextView < NSTextView

	def awakeFromNib()
		format()
	end
	
	def didChangeText()
		super_didChangeText()
		format()
	end
	
	def format()
		lexer = RubyLex.new
		lexer.set_input(StringIO.new(self.string()))
		while token = lexer.token
			attrs = {
				NSFontAttributeName => NSFont.fontWithName_size_("Inconsolata", 12.0),
			}
			case token 
			when RubyToken::TkCLASS, RubyToken::TkDEF, RubyToken::TkWHILE, RubyToken::TkBEGIN, RubyToken::TkEND,
				 RubyToken::TkDO, RubyToken::TkWHILE, RubyToken::TkIF, RubyToken::TkTHEN
				attrs[NSForegroundColorAttributeName] = NSColor.redColor()
			when RubyToken::TkSTRING, RubyToken::TkDSTRING
				attrs[NSForegroundColorAttributeName] = NSColor.blueColor()
			when RubyToken::TkCOMMENT
				attrs[NSForegroundColorAttributeName] = NSColor.grayColor()
			end
			begin
				textStorage().setAttributes_range_(attrs, NSMakeRange(token.seek, lexer.seek - token.seek))
			rescue
			end
		end
	end

end
