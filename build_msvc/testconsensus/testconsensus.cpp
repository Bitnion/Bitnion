#include <stdlib.h>
#include <stdio.h>

#include "script/bitnionconsensus.h"

int main(int argc, char* argv[])
{
    if (argc < 2) {
        fprintf(stderr, "Usage: %s hex-scriptpubkey\\n", argv[0]);
        return 1;
    }

    const unsigned char scriptPubKey[] = { 0x51 }; // OP_TRUE for testing
    const unsigned char txTo[] = { 0x00 }; // Dummy tx
    unsigned int flags = bitnionconsensus_SCRIPT_FLAGS_VERIFY_ALL;
    bitnionconsensus_error err;

    int result = bitnionconsensus_verify_script(scriptPubKey, sizeof(scriptPubKey),
                                                 txTo, sizeof(txTo),
                                                 flags, &err);

    printf("Bitnion Script verification result: %d\\n", result);
    printf("Bitnion Script verification error: %d\\n", err);

    return 0;
}
