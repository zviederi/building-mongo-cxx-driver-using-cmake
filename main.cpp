// Soruce from 
// http://mongocxx.org/mongocxx-v3/installation/#step-6-test-your-installation

#include <cstdlib>
#include <iostream>
#include <string>

#include <bsoncxx/json.hpp>
#include <bsoncxx/builder/stream/document.hpp>
#include <bsoncxx/builder/basic/document.hpp>
#include <bsoncxx/builder/basic/kvp.hpp>
#include <bsoncxx/stdx/make_unique.hpp>

#include <mongocxx/uri.hpp>
#include <mongocxx/client.hpp>
#include <mongocxx/instance.hpp>
#include <mongocxx/logger.hpp>
#include <mongocxx/options/client.hpp>
#include <mongocxx/options/ssl.hpp>

#include "config.h"

// Copied from
// https://github.com/mongodb/mongo-cxx-driver/blob/master/examples/mongocxx/index.cpp
namespace {
    class logger final : public mongocxx::logger {
    public:
        explicit logger(std::ostream* stream) : _stream(stream) {}

        void operator()(mongocxx::log_level level,
                        bsoncxx::stdx::string_view domain,
                        bsoncxx::stdx::string_view message) noexcept override {
            if (level >= mongocxx::log_level::k_trace)
                return;
            *_stream << '[' << mongocxx::to_string(level) << '@' << domain << "] " << message << '\n';
        }

    private:
        std::ostream* const _stream;
    };
} 

int main(int, char**) {
    
    mongocxx::instance inst{bsoncxx::stdx::make_unique<logger>(&std::cout)};
    try {       
        mongocxx::options::ssl ssl_opts{};
        ssl_opts.ca_file(CA_FILE_STR);
        ssl_opts.pem_file(PEM_FILE_STR);       
        ssl_opts.allow_invalid_certificates(true);
        mongocxx::options::client client_opts{};
        client_opts.ssl_opts(ssl_opts);       

        auto uri = mongocxx::uri{CONNECTION_URI_STR};
        auto conn = mongocxx::client{uri, client_opts};
        
        bsoncxx::builder::stream::document document{};

        auto collection = conn["testdb"]["testcollection"];
        document << "hello" << "world";

        collection.insert_one(document.view());
        auto cursor = collection.find({});

        for (auto&& doc : cursor) {
            std::cout << bsoncxx::to_json(doc) << std::endl;
        }
     } catch (const std::exception& xcp) {
        std::cout << "connection failed: " << xcp.what() << "\n";
        return EXIT_FAILURE;
    }
}