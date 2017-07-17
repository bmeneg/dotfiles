#!/usr/env python

from subprocess import check_output

def get_password_from_file(file_type, filename):
    if file_type == "pgp":
        return check_output("gpg2 --no-tty -q -d {}".format(filename),
                            shell=True).strip("\n")
    else:
        raise TypeError("{} is not supported".format(file_type))

if __name__ == "__main__":
    print get_password_from_file("pgp", "~/Mail/brdeoliv-at-redhat-imap.gpg")
