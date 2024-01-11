s script creates a new user on the local machine.
# You must supply a username as an argument to the script.
# Optionally, you can also provide a comment for the account as an argument.
# A password will be automatically generated for the account.
# The username, password, and host for the account will be displayed.

# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]]; then
    echo 'Please run with sudo or as root.' >&2
    exit 1
fi

# If they don't supply at least one argument, then give them help.
if [[ "${#}" -lt 1 ]]; then
    echo "Usage: ${0} USER_NAME [COMMENT]..." >&2
    echo 'Create an account on the local system with the name of USER_NAME and a comment field of COMMENT.' >&2
    exit 1
fi

# The first parameter is the user name.
USER_NAME="${1}"

# The rest of the parameters are for the comments.
COMMENT="${@}"

# Check if the user already exists.
if id "${USER_NAME}" &>/dev/null; then
    echo "User ${USER_NAME} already exists." >&2
    exit 1
fi

# Generate a password.
PASSWORD=$(date +%s%N | sha256sum | head -c48)

# Create the user with the password.
useradd -c "${COMMENT}" -m "${USER_NAME}" &> /dev/null

# Check to see if the useradd command succeeded.
if [[ "${?}" -ne 0 ]]; then
    echo 'The account could not be created.' >&2
    exit 1
fi

# Set the password.
echo "${USER_NAME}:${PASSWORD}" | chpasswd &> /dev/null

# Check to see if the chpasswd command succeeded.
if [[ "${?}" -ne 0 ]]; then
    echo 'The password for the account could not be set.' >&2
    exit 1
fi

# Force password change on first login.
passwd -e "${USER_NAME}" &> /dev/null

# Display the information.
echo
echo 'Username:'
echo "${USER_NAME}"
echo
echo 'Password:'
echo "${PASSWORD}"
echo
echo 'Host:'
echo "${HOSTNAME}"
exit 0

