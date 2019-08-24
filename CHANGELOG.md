# Changelog
All notable changes to this project will be documented in this file.

## 0.4.0 - 2019-08-17
 - Added NSOne::Transport::RateLimitExceeded exception and get_rates method to add to the NSOne::Response::Base class the rate limit headers to help with exponential backoff
 - Added billataglance and plan methods for account API
 - Added Feeds APIs
 - Seperated API version string from static paths to allow easy to change, versions in the future.

## 0.3.4 - 2019-08-06
- change module name

## 0.3.3 - 2019-08-06
- Added jobs and job API calls for NS1 monitoring jobs
- Added account and account_overage calls
- Added Stats calls (per account, zone, record, network and region) for QPS and Usage
- Added Docs

## 0.2.0 - 2018-12-07
- [Added] `Response#status` returns status code information as an integer - #1
- [Added] Changelog

## 0.1.0 - 2018-04-10
- Initial release supporting CRUD operations for zones and records
