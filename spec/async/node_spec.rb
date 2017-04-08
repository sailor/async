# Copyright, 2017, by Samuel G. D. Williams. <http://www.codeotaku.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'benchmark'

RSpec.describe Async::Node do
	describe '#parent=' do
		let(:child) {Async::Node.new(subject)}
		
		it "should construct nested tree" do
			expect(child.parent).to be subject
			expect(subject.children).to include(child)
		end
		
		it "should break nested tree" do
			child.parent = nil
			
			expect(child.parent).to be_nil
			expect(subject.children).to be_empty
		end
	end
	
	describe '#consume' do
		let(:middle) {Async::Node.new(subject)}
		let(:bottom) {Async::Node.new(middle)}
		
		it "should merge child into parent" do
			expect(bottom.parent).to be middle
			
			middle.consume
			
			expect(middle.parent).to be_nil
			expect(middle.children).to be_empty
			
			expect(bottom.parent).to be subject
			expect(subject.children).to include(bottom)
		end
	end
end
