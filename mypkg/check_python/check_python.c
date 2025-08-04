#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LOG_FILE "/tmp/python_ver.log"

int main() {
    FILE *fp;
    char buffer[128];
    char version[128] = {0};

    // open pipe to read output from shell command
    fp = popen("python3.11 --version 2>&1", "r");
    if (fp == NULL) {
        fprintf(stderr, "Error: Failed to run command.\n");
        return 1;
    }

    // read output first line
    if (fgets(buffer, sizeof(buffer), fp) != NULL) {
        if (strstr(buffer, "Python 3.11") != NULL) {
            snprintf(version, sizeof(version), "Detected Python Version: %s", buffer);
        } else {
            snprintf(version, sizeof(version), "Error: Python 3.11 not found\n");
        }
    } else {
        snprintf(version, sizeof(version), "Error: Python 3.11 not found\n");
    }

    pclose(fp);

    // print on terminal
    printf("%s", version);

    // write log to file
    FILE *log_fp = fopen(LOG_FILE, "w");
    if (log_fp != NULL) {
        fprintf(log_fp, "%s", version);
        fclose(log_fp);
    } else {
        fprintf(stderr, "Error: Cannot open log file.\n");
    }

    return 0;
}

