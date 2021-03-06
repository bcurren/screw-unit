require "#{File.dirname(__FILE__)}/../../screw_unit_spec_helper"

module ScrewUnit
  module Resources
    describe File do
      attr_reader :dir, :file

      before do
        @dir = ::File.dirname(__FILE__)
        @file = File.new("/foo.js", absolute_path)
      end

      describe "#get" do
        def absolute_path
          "#{dir}/file_system_fixtures/foo.js"
        end
        attr_reader :response_code, :headers, :body

        before do
          ::File.exists?(absolute_path).should be_true
          @response_code, @headers, @body = file.get
        end

        it "returns 200 as the response code" do
          response_code.should == 200
        end

        it "returs the file's mtime as the 'Last-Modified' header" do
          headers['Last-Modified'].should == ::File.mtime(absolute_path).rfc822
        end

        it "returns the contents of the file as the response body" do
          body.should == ::File.read(absolute_path)
        end

        context "when the file has a .js extension" do
          it "has a Content-Type header of 'text/javascript'" do
            headers['Content-Type'].should == "text/javascript"
          end
        end

        context "when the file has a .css extension" do
          def absolute_path
            "#{dir}/file_system_fixtures/foo.css"
          end

          it "has a Content-Type header of 'text/css'" do
            headers['Content-Type'].should == "text/css"
          end
        end

        context "when the file has a .png extension" do
          def absolute_path
            "#{dir}/file_system_fixtures/foo.png"
          end

          it "has a Content-Type header of 'text/png'" do
            headers['Content-Type'].should == "image/png"
          end
        end

        context "when the file has a .jpg extension" do
          def absolute_path
            "#{dir}/file_system_fixtures/foo.jpg"
          end

          it "has a Content-Type header of 'image/jpeg'" do
            headers['Content-Type'].should == "image/jpeg"
          end
        end

        context "when the file has a .jpeg extension" do
          def absolute_path
            "#{dir}/file_system_fixtures/foo.jpeg"
          end

          it "has a Content-Type header of 'image/jpeg'" do
            headers['Content-Type'].should == "image/jpeg"
          end
        end
      end
    end
  end
end