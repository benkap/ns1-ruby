require "spec_helper"

RSpec.describe NSOne::API::Records do
  let(:api_key) { "s3cr3tk3y" }
  let(:client) { NSOne::Client.new(api_key) }

  describe "#record" do
    it "raises an error on nil zone" do
      expect {
        client.record(nil, nil, nil)
      }.to raise_error NSOne::MissingParameter
    end

    it "requests GET /zones/:zone/:domain/:type" do
      request = stub_api(:get, "/zones/example.com/www.example.com/A")

      response = client.record("example.com", "www.example.com", "A")

      expect(request).to have_been_requested
      expect(response.status).to eq 200
    end
  end

  describe "#create_record" do
    it "raises an error when no zone, record, or type" do
      expect {
        client.create_record("", "", "", { ttl: 60 })
      }.to raise_error NSOne::MissingParameter
    end

    it "raises an error when no answers" do
      expect {
        client.create_record("example.com", "www.example.com", "A", { ttl: 60 })
      }.to raise_error NSOne::MissingParameter
    end

    it "requests PUT /zones/:zone/:domain/:type" do
      expected_body = { answers: [],  zone: "example.com", domain: "www.example.com", type: "A" }
      request = stub_api(:put, "/zones/example.com/www.example.com/A")
                  .with(body: JSON.dump(expected_body))

      response = client.create_record("example.com", "www.example.com", "A", { answers: [] })

      expect(request).to have_been_requested
      expect(response.status).to eq 200
    end
  end

  describe "#modify_record" do
    it "requests POST /zones/:zone/:domain/:type" do
      expected_body = { use_client_subnet: false }
      request = stub_api(:post, "/zones/example.com/www.example.com/CNAME")
                  .with(body: JSON.dump(expected_body))

      response = client.modify_record("example.com", "www.example.com", "CNAME", { use_client_subnet: false } )

      expect(request).to have_been_requested
      expect(response.status).to eq 200
    end
  end

  describe "#delete_record" do
    it "requests DELETE /zones/:zone/:domain/:type" do
      request = stub_api(:delete, "/zones/example.com/www.example.com/CNAME")

      response = client.delete_record("example.com", "www.example.com", "CNAME")

      expect(request).to have_been_requested
      expect(response.status).to eq 200
    end
  end
end
