require "spec_helper"

RSpec.describe NSOne::API::Zones do
  let(:api_key) { "s3cr3tk3y" }
  let(:client) { NSOne::Client.new(api_key) }

  describe "#zones" do
    it "requests GET /zones" do
      request = stub_api(:get, "/zones")

      client.zones

      expect(request).to have_been_requested
    end
  end

  describe "#zone" do
    it "raises an error on nil zone" do
      expect {
        client.zone(nil)
      }.to raise_error NSOne::MissingParameter
    end

    it "requests GET /zones" do
      request = stub_api(:get, "/zones/example.com")

      response = client.zone("example.com")

      expect(request).to have_been_requested
      expect(response.status).to eq 200
    end
  end

  describe "#create_zone" do
    it "raises an error when no zone" do
      expect {
        client.create_zone(nil, nx_ttl: 600)
      }.to raise_error NSOne::MissingParameter
    end

    it "requests PUT /zones/:zone" do
      expected_body = { zone: "example.com" }
      request = stub_api(:put, "/zones/example.com")
                  .with(body: JSON.dump(expected_body))

      response = client.create_zone("example.com")

      expect(request).to have_been_requested
      expect(response.status).to eq 200
    end
  end

  describe "#modify_zone" do
    it "requests POST /zones/:zone" do
      expected_body = { ttl: 600 }
      request = stub_api(:post, "/zones/example.com")
                  .with(body: JSON.dump(expected_body))

      response = client.modify_zone("example.com", ttl: 600)

      expect(request).to have_been_requested
      expect(response.status).to eq 200
    end
  end

  describe "#delete_zone" do
    it "requests DELETE /zones/:zone" do
      request = stub_api(:delete, "/zones/example.com")

      response = client.delete_zone("example.com")

      expect(request).to have_been_requested
      expect(response.status).to eq 200
    end
  end
end
