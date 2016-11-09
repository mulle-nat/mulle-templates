#! /bin/sh

PROJECT="MulleObjCDeveloper" # requires camel-case
DESC="mulle-objc Developer Environment"
DEPENDENCIES='${DEPENDENCY_TAP}/mulle-allocator
${DEPENDENCY_TAP}/mulle-c11
${DEPENDENCY_TAP}/mulle-concurrent
${DEPENDENCY_TAP}/mulle-container
${DEPENDENCY_TAP}/mulle-vararg
${DEPENDENCY_TAP}/mulle-thread'  # no camel case, will be evaled later!
LANGUAGE=c                       # c,cpp, objc
VERSION="`head -1 VERSION`"

#
# Ideally you don't hafta change anything below this line
#
# source mulle-homebrew.sh (clumsily)
MULLE_BOOTSTRAP_FAIL_PREFIX="release.sh"

. ./bin/repository-info.sh || exit 1
. ./bin/mulle-homebrew/mulle-homebrew.sh || exit 1


# parse options
homebrew_parse_options "$@"

# dial past options
while [ $# -ne 0 ]
do
   case "$1" in
      -*)
         shift
      ;;
      *)
         break;
      ;;
   esac
done

#
# these can usually be deduced, if you follow the conventions
#
NAME="`get_name_from_project "${PROJECT}" "${LANGUAGE}"`"


# --- HOMEBREW FORMULA ---
# Information needed to construct a proper brew formula
#
HOMEPAGE="${REMOTEURL}/${NAME}"


# --- HOMEBREW TAP ---
# Specify to where and under what bame to publish via your brew tap
#
RBFILE="${NAME}.rb"                    # ruby file for brew
HOMEBREWTAP="../homebrew-software"     # your tap repository path


# --- GIT ---
# tag to tag your release
# and the origin where
TAG="${1:-${TAGPREFIX}${VERSION}}"

[ -z "${VERSION}" ] && fail "VERSION is empty"

main()
{
   git_main "${ORIGIN}" "${TAG}" || exit 1
   homebrew_main
}

main "$@"