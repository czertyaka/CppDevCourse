#include <cstddef>
#include "archivelib.hpp"

void foo(const void* const data, const std::size_t size) {
    archive_data(const_cast<void*>(data), size);
}
