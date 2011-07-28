#ifndef BUILDINFO_VERSION_H_INCLUDED_04e35efddbcb44bc98e41fd0dc3b586d
#define BUILDINFO_VERSION_H_INCLUDED_04e35efddbcb44bc98e41fd0dc3b586d

#include <time.h> // time_t

#ifdef __cplusplus
extern "C" {
#endif

const char* buildinfo_program_version();

const char* buildinfo_version();

const char* buildinfo_full_version();

const char* buildinfo_compile_time();

time_t      buildinfo_compile_timestamp();

#ifdef __cplusplus
} // extern "C"
#endif

#endif
