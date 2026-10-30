/* Optional compatibility shim for containers that expose /proc/self/exe but
 * do not expose /proc/<own-pid>/exe. Only the current process's executable
 * pathname is redirected to its permitted equivalent. No Lean code, kernel,
 * arithmetic, or proof checking is changed. Not needed on ordinary Linux. */
#define _GNU_SOURCE
#include <dlfcn.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

ssize_t readlink(const char *path, char *buf, size_t size) {
    static ssize_t (*real_readlink)(const char *, char *, size_t);
    if (!real_readlink) real_readlink = dlsym(RTLD_NEXT, "readlink");
    char own_exe[64];
    snprintf(own_exe, sizeof own_exe, "/proc/%ld/exe", (long)getpid());
    if (strcmp(path, own_exe) == 0) path = "/proc/self/exe";
    return real_readlink(path, buf, size);
}
