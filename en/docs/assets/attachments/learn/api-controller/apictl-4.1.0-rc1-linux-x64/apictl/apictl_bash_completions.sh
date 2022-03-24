# bash completion for apictl                               -*- shell-script -*-

__apictl_debug()
{
    if [[ -n ${BASH_COMP_DEBUG_FILE} ]]; then
        echo "$*" >> "${BASH_COMP_DEBUG_FILE}"
    fi
}

# Homebrew on Macs have version 1.3 of bash-completion which doesn't include
# _init_completion. This is a very minimal version of that function.
__apictl_init_completion()
{
    COMPREPLY=()
    _get_comp_words_by_ref "$@" cur prev words cword
}

__apictl_index_of_word()
{
    local w word=$1
    shift
    index=0
    for w in "$@"; do
        [[ $w = "$word" ]] && return
        index=$((index+1))
    done
    index=-1
}

__apictl_contains_word()
{
    local w word=$1; shift
    for w in "$@"; do
        [[ $w = "$word" ]] && return
    done
    return 1
}

__apictl_handle_go_custom_completion()
{
    __apictl_debug "${FUNCNAME[0]}: cur is ${cur}, words[*] is ${words[*]}, #words[@] is ${#words[@]}"

    local shellCompDirectiveError=1
    local shellCompDirectiveNoSpace=2
    local shellCompDirectiveNoFileComp=4
    local shellCompDirectiveFilterFileExt=8
    local shellCompDirectiveFilterDirs=16

    local out requestComp lastParam lastChar comp directive args

    # Prepare the command to request completions for the program.
    # Calling ${words[0]} instead of directly apictl allows to handle aliases
    args=("${words[@]:1}")
    requestComp="${words[0]} __completeNoDesc ${args[*]}"

    lastParam=${words[$((${#words[@]}-1))]}
    lastChar=${lastParam:$((${#lastParam}-1)):1}
    __apictl_debug "${FUNCNAME[0]}: lastParam ${lastParam}, lastChar ${lastChar}"

    if [ -z "${cur}" ] && [ "${lastChar}" != "=" ]; then
        # If the last parameter is complete (there is a space following it)
        # We add an extra empty parameter so we can indicate this to the go method.
        __apictl_debug "${FUNCNAME[0]}: Adding extra empty parameter"
        requestComp="${requestComp} \"\""
    fi

    __apictl_debug "${FUNCNAME[0]}: calling ${requestComp}"
    # Use eval to handle any environment variables and such
    out=$(eval "${requestComp}" 2>/dev/null)

    # Extract the directive integer at the very end of the output following a colon (:)
    directive=${out##*:}
    # Remove the directive
    out=${out%:*}
    if [ "${directive}" = "${out}" ]; then
        # There is not directive specified
        directive=0
    fi
    __apictl_debug "${FUNCNAME[0]}: the completion directive is: ${directive}"
    __apictl_debug "${FUNCNAME[0]}: the completions are: ${out[*]}"

    if [ $((directive & shellCompDirectiveError)) -ne 0 ]; then
        # Error code.  No completion.
        __apictl_debug "${FUNCNAME[0]}: received error from custom completion go code"
        return
    else
        if [ $((directive & shellCompDirectiveNoSpace)) -ne 0 ]; then
            if [[ $(type -t compopt) = "builtin" ]]; then
                __apictl_debug "${FUNCNAME[0]}: activating no space"
                compopt -o nospace
            fi
        fi
        if [ $((directive & shellCompDirectiveNoFileComp)) -ne 0 ]; then
            if [[ $(type -t compopt) = "builtin" ]]; then
                __apictl_debug "${FUNCNAME[0]}: activating no file completion"
                compopt +o default
            fi
        fi
    fi

    if [ $((directive & shellCompDirectiveFilterFileExt)) -ne 0 ]; then
        # File extension filtering
        local fullFilter filter filteringCmd
        # Do not use quotes around the $out variable or else newline
        # characters will be kept.
        for filter in ${out[*]}; do
            fullFilter+="$filter|"
        done

        filteringCmd="_filedir $fullFilter"
        __apictl_debug "File filtering command: $filteringCmd"
        $filteringCmd
    elif [ $((directive & shellCompDirectiveFilterDirs)) -ne 0 ]; then
        # File completion for directories only
        local subDir
        # Use printf to strip any trailing newline
        subdir=$(printf "%s" "${out[0]}")
        if [ -n "$subdir" ]; then
            __apictl_debug "Listing directories in $subdir"
            __apictl_handle_subdirs_in_dir_flag "$subdir"
        else
            __apictl_debug "Listing directories in ."
            _filedir -d
        fi
    else
        while IFS='' read -r comp; do
            COMPREPLY+=("$comp")
        done < <(compgen -W "${out[*]}" -- "$cur")
    fi
}

__apictl_handle_reply()
{
    __apictl_debug "${FUNCNAME[0]}"
    local comp
    case $cur in
        -*)
            if [[ $(type -t compopt) = "builtin" ]]; then
                compopt -o nospace
            fi
            local allflags
            if [ ${#must_have_one_flag[@]} -ne 0 ]; then
                allflags=("${must_have_one_flag[@]}")
            else
                allflags=("${flags[*]} ${two_word_flags[*]}")
            fi
            while IFS='' read -r comp; do
                COMPREPLY+=("$comp")
            done < <(compgen -W "${allflags[*]}" -- "$cur")
            if [[ $(type -t compopt) = "builtin" ]]; then
                [[ "${COMPREPLY[0]}" == *= ]] || compopt +o nospace
            fi

            # complete after --flag=abc
            if [[ $cur == *=* ]]; then
                if [[ $(type -t compopt) = "builtin" ]]; then
                    compopt +o nospace
                fi

                local index flag
                flag="${cur%=*}"
                __apictl_index_of_word "${flag}" "${flags_with_completion[@]}"
                COMPREPLY=()
                if [[ ${index} -ge 0 ]]; then
                    PREFIX=""
                    cur="${cur#*=}"
                    ${flags_completion[${index}]}
                    if [ -n "${ZSH_VERSION}" ]; then
                        # zsh completion needs --flag= prefix
                        eval "COMPREPLY=( \"\${COMPREPLY[@]/#/${flag}=}\" )"
                    fi
                fi
            fi
            return 0;
            ;;
    esac

    # check if we are handling a flag with special work handling
    local index
    __apictl_index_of_word "${prev}" "${flags_with_completion[@]}"
    if [[ ${index} -ge 0 ]]; then
        ${flags_completion[${index}]}
        return
    fi

    # we are parsing a flag and don't have a special handler, no completion
    if [[ ${cur} != "${words[cword]}" ]]; then
        return
    fi

    local completions
    completions=("${commands[@]}")
    if [[ ${#must_have_one_noun[@]} -ne 0 ]]; then
        completions+=("${must_have_one_noun[@]}")
    elif [[ -n "${has_completion_function}" ]]; then
        # if a go completion function is provided, defer to that function
        __apictl_handle_go_custom_completion
    fi
    if [[ ${#must_have_one_flag[@]} -ne 0 ]]; then
        completions+=("${must_have_one_flag[@]}")
    fi
    while IFS='' read -r comp; do
        COMPREPLY+=("$comp")
    done < <(compgen -W "${completions[*]}" -- "$cur")

    if [[ ${#COMPREPLY[@]} -eq 0 && ${#noun_aliases[@]} -gt 0 && ${#must_have_one_noun[@]} -ne 0 ]]; then
        while IFS='' read -r comp; do
            COMPREPLY+=("$comp")
        done < <(compgen -W "${noun_aliases[*]}" -- "$cur")
    fi

    if [[ ${#COMPREPLY[@]} -eq 0 ]]; then
		if declare -F __apictl_custom_func >/dev/null; then
			# try command name qualified custom func
			__apictl_custom_func
		else
			# otherwise fall back to unqualified for compatibility
			declare -F __custom_func >/dev/null && __custom_func
		fi
    fi

    # available in bash-completion >= 2, not always present on macOS
    if declare -F __ltrim_colon_completions >/dev/null; then
        __ltrim_colon_completions "$cur"
    fi

    # If there is only 1 completion and it is a flag with an = it will be completed
    # but we don't want a space after the =
    if [[ "${#COMPREPLY[@]}" -eq "1" ]] && [[ $(type -t compopt) = "builtin" ]] && [[ "${COMPREPLY[0]}" == --*= ]]; then
       compopt -o nospace
    fi
}

# The arguments should be in the form "ext1|ext2|extn"
__apictl_handle_filename_extension_flag()
{
    local ext="$1"
    _filedir "@(${ext})"
}

__apictl_handle_subdirs_in_dir_flag()
{
    local dir="$1"
    pushd "${dir}" >/dev/null 2>&1 && _filedir -d && popd >/dev/null 2>&1 || return
}

__apictl_handle_flag()
{
    __apictl_debug "${FUNCNAME[0]}: c is $c words[c] is ${words[c]}"

    # if a command required a flag, and we found it, unset must_have_one_flag()
    local flagname=${words[c]}
    local flagvalue
    # if the word contained an =
    if [[ ${words[c]} == *"="* ]]; then
        flagvalue=${flagname#*=} # take in as flagvalue after the =
        flagname=${flagname%=*} # strip everything after the =
        flagname="${flagname}=" # but put the = back
    fi
    __apictl_debug "${FUNCNAME[0]}: looking for ${flagname}"
    if __apictl_contains_word "${flagname}" "${must_have_one_flag[@]}"; then
        must_have_one_flag=()
    fi

    # if you set a flag which only applies to this command, don't show subcommands
    if __apictl_contains_word "${flagname}" "${local_nonpersistent_flags[@]}"; then
      commands=()
    fi

    # keep flag value with flagname as flaghash
    # flaghash variable is an associative array which is only supported in bash > 3.
    if [[ -z "${BASH_VERSION}" || "${BASH_VERSINFO[0]}" -gt 3 ]]; then
        if [ -n "${flagvalue}" ] ; then
            flaghash[${flagname}]=${flagvalue}
        elif [ -n "${words[ $((c+1)) ]}" ] ; then
            flaghash[${flagname}]=${words[ $((c+1)) ]}
        else
            flaghash[${flagname}]="true" # pad "true" for bool flag
        fi
    fi

    # skip the argument to a two word flag
    if [[ ${words[c]} != *"="* ]] && __apictl_contains_word "${words[c]}" "${two_word_flags[@]}"; then
			  __apictl_debug "${FUNCNAME[0]}: found a flag ${words[c]}, skip the next argument"
        c=$((c+1))
        # if we are looking for a flags value, don't show commands
        if [[ $c -eq $cword ]]; then
            commands=()
        fi
    fi

    c=$((c+1))

}

__apictl_handle_noun()
{
    __apictl_debug "${FUNCNAME[0]}: c is $c words[c] is ${words[c]}"

    if __apictl_contains_word "${words[c]}" "${must_have_one_noun[@]}"; then
        must_have_one_noun=()
    elif __apictl_contains_word "${words[c]}" "${noun_aliases[@]}"; then
        must_have_one_noun=()
    fi

    nouns+=("${words[c]}")
    c=$((c+1))
}

__apictl_handle_command()
{
    __apictl_debug "${FUNCNAME[0]}: c is $c words[c] is ${words[c]}"

    local next_command
    if [[ -n ${last_command} ]]; then
        next_command="_${last_command}_${words[c]//:/__}"
    else
        if [[ $c -eq 0 ]]; then
            next_command="_apictl_root_command"
        else
            next_command="_${words[c]//:/__}"
        fi
    fi
    c=$((c+1))
    __apictl_debug "${FUNCNAME[0]}: looking for ${next_command}"
    declare -F "$next_command" >/dev/null && $next_command
}

__apictl_handle_word()
{
    if [[ $c -ge $cword ]]; then
        __apictl_handle_reply
        return
    fi
    __apictl_debug "${FUNCNAME[0]}: c is $c words[c] is ${words[c]}"
    if [[ "${words[c]}" == -* ]]; then
        __apictl_handle_flag
    elif __apictl_contains_word "${words[c]}" "${commands[@]}"; then
        __apictl_handle_command
    elif [[ $c -eq 0 ]]; then
        __apictl_handle_command
    elif __apictl_contains_word "${words[c]}" "${command_aliases[@]}"; then
        # aliashash variable is an associative array which is only supported in bash > 3.
        if [[ -z "${BASH_VERSION}" || "${BASH_VERSINFO[0]}" -gt 3 ]]; then
            words[c]=${aliashash[${words[c]}]}
            __apictl_handle_command
        else
            __apictl_handle_noun
        fi
    else
        __apictl_handle_noun
    fi
    __apictl_handle_word
}

_apictl_add_env()
{
    last_command="apictl_add_env"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--admin=")
    two_word_flags+=("--admin")
    local_nonpersistent_flags+=("--admin")
    local_nonpersistent_flags+=("--admin=")
    flags+=("--apim=")
    two_word_flags+=("--apim")
    local_nonpersistent_flags+=("--apim")
    local_nonpersistent_flags+=("--apim=")
    flags+=("--devportal=")
    two_word_flags+=("--devportal")
    local_nonpersistent_flags+=("--devportal")
    local_nonpersistent_flags+=("--devportal=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--mi=")
    two_word_flags+=("--mi")
    local_nonpersistent_flags+=("--mi")
    local_nonpersistent_flags+=("--mi=")
    flags+=("--publisher=")
    two_word_flags+=("--publisher")
    local_nonpersistent_flags+=("--publisher")
    local_nonpersistent_flags+=("--publisher=")
    flags+=("--registration=")
    two_word_flags+=("--registration")
    local_nonpersistent_flags+=("--registration")
    local_nonpersistent_flags+=("--registration=")
    flags+=("--token=")
    two_word_flags+=("--token")
    local_nonpersistent_flags+=("--token")
    local_nonpersistent_flags+=("--token=")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_add_help()
{
    last_command="apictl_add_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_add()
{
    last_command="apictl_add"

    command_aliases=()

    commands=()
    commands+=("env")
    commands+=("help")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_aws_help()
{
    last_command="apictl_aws_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_aws_init()
{
    last_command="apictl_aws_init"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--force")
    flags+=("-f")
    local_nonpersistent_flags+=("--force")
    local_nonpersistent_flags+=("-f")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--name=")
    two_word_flags+=("--name")
    two_word_flags+=("-n")
    local_nonpersistent_flags+=("--name")
    local_nonpersistent_flags+=("--name=")
    local_nonpersistent_flags+=("-n")
    flags+=("--stage=")
    two_word_flags+=("--stage")
    two_word_flags+=("-s")
    local_nonpersistent_flags+=("--stage")
    local_nonpersistent_flags+=("--stage=")
    local_nonpersistent_flags+=("-s")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--name=")
    must_have_one_flag+=("-n")
    must_have_one_flag+=("--stage=")
    must_have_one_flag+=("-s")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_aws()
{
    last_command="apictl_aws"

    command_aliases=()

    commands=()
    commands+=("help")
    commands+=("init")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_bundle()
{
    last_command="apictl_bundle"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--destination=")
    two_word_flags+=("--destination")
    two_word_flags+=("-d")
    local_nonpersistent_flags+=("--destination")
    local_nonpersistent_flags+=("--destination=")
    local_nonpersistent_flags+=("-d")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--source=")
    two_word_flags+=("--source")
    two_word_flags+=("-s")
    local_nonpersistent_flags+=("--source")
    local_nonpersistent_flags+=("--source=")
    local_nonpersistent_flags+=("-s")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--source=")
    must_have_one_flag+=("-s")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_change-status_api()
{
    last_command="apictl_change-status_api"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--action=")
    two_word_flags+=("--action")
    two_word_flags+=("-a")
    local_nonpersistent_flags+=("--action")
    local_nonpersistent_flags+=("--action=")
    local_nonpersistent_flags+=("-a")
    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--name=")
    two_word_flags+=("--name")
    two_word_flags+=("-n")
    local_nonpersistent_flags+=("--name")
    local_nonpersistent_flags+=("--name=")
    local_nonpersistent_flags+=("-n")
    flags+=("--provider=")
    two_word_flags+=("--provider")
    two_word_flags+=("-r")
    local_nonpersistent_flags+=("--provider")
    local_nonpersistent_flags+=("--provider=")
    local_nonpersistent_flags+=("-r")
    flags+=("--version=")
    two_word_flags+=("--version")
    two_word_flags+=("-v")
    local_nonpersistent_flags+=("--version")
    local_nonpersistent_flags+=("--version=")
    local_nonpersistent_flags+=("-v")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--action=")
    must_have_one_flag+=("-a")
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_flag+=("--name=")
    must_have_one_flag+=("-n")
    must_have_one_flag+=("--version=")
    must_have_one_flag+=("-v")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_change-status_api-product()
{
    last_command="apictl_change-status_api-product"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--action=")
    two_word_flags+=("--action")
    two_word_flags+=("-a")
    local_nonpersistent_flags+=("--action")
    local_nonpersistent_flags+=("--action=")
    local_nonpersistent_flags+=("-a")
    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--name=")
    two_word_flags+=("--name")
    two_word_flags+=("-n")
    local_nonpersistent_flags+=("--name")
    local_nonpersistent_flags+=("--name=")
    local_nonpersistent_flags+=("-n")
    flags+=("--provider=")
    two_word_flags+=("--provider")
    two_word_flags+=("-r")
    local_nonpersistent_flags+=("--provider")
    local_nonpersistent_flags+=("--provider=")
    local_nonpersistent_flags+=("-r")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--action=")
    must_have_one_flag+=("-a")
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_flag+=("--name=")
    must_have_one_flag+=("-n")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_change-status_help()
{
    last_command="apictl_change-status_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_change-status()
{
    last_command="apictl_change-status"

    command_aliases=()

    commands=()
    commands+=("api")
    commands+=("api-product")
    commands+=("help")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_delete_api()
{
    last_command="apictl_delete_api"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--name=")
    two_word_flags+=("--name")
    two_word_flags+=("-n")
    local_nonpersistent_flags+=("--name")
    local_nonpersistent_flags+=("--name=")
    local_nonpersistent_flags+=("-n")
    flags+=("--provider=")
    two_word_flags+=("--provider")
    two_word_flags+=("-r")
    local_nonpersistent_flags+=("--provider")
    local_nonpersistent_flags+=("--provider=")
    local_nonpersistent_flags+=("-r")
    flags+=("--version=")
    two_word_flags+=("--version")
    two_word_flags+=("-v")
    local_nonpersistent_flags+=("--version")
    local_nonpersistent_flags+=("--version=")
    local_nonpersistent_flags+=("-v")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_flag+=("--name=")
    must_have_one_flag+=("-n")
    must_have_one_flag+=("--version=")
    must_have_one_flag+=("-v")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_delete_api-product()
{
    last_command="apictl_delete_api-product"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--name=")
    two_word_flags+=("--name")
    two_word_flags+=("-n")
    local_nonpersistent_flags+=("--name")
    local_nonpersistent_flags+=("--name=")
    local_nonpersistent_flags+=("-n")
    flags+=("--provider=")
    two_word_flags+=("--provider")
    two_word_flags+=("-r")
    local_nonpersistent_flags+=("--provider")
    local_nonpersistent_flags+=("--provider=")
    local_nonpersistent_flags+=("-r")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_flag+=("--name=")
    must_have_one_flag+=("-n")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_delete_app()
{
    last_command="apictl_delete_app"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--name=")
    two_word_flags+=("--name")
    two_word_flags+=("-n")
    local_nonpersistent_flags+=("--name")
    local_nonpersistent_flags+=("--name=")
    local_nonpersistent_flags+=("-n")
    flags+=("--owner=")
    two_word_flags+=("--owner")
    two_word_flags+=("-o")
    local_nonpersistent_flags+=("--owner")
    local_nonpersistent_flags+=("--owner=")
    local_nonpersistent_flags+=("-o")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_flag+=("--name=")
    must_have_one_flag+=("-n")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_delete_help()
{
    last_command="apictl_delete_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_delete()
{
    last_command="apictl_delete"

    command_aliases=()

    commands=()
    commands+=("api")
    commands+=("api-product")
    commands+=("app")
    commands+=("help")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_export_api()
{
    last_command="apictl_export_api"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--latest")
    local_nonpersistent_flags+=("--latest")
    flags+=("--name=")
    two_word_flags+=("--name")
    two_word_flags+=("-n")
    local_nonpersistent_flags+=("--name")
    local_nonpersistent_flags+=("--name=")
    local_nonpersistent_flags+=("-n")
    flags+=("--preserve-status")
    local_nonpersistent_flags+=("--preserve-status")
    flags+=("--provider=")
    two_word_flags+=("--provider")
    two_word_flags+=("-r")
    local_nonpersistent_flags+=("--provider")
    local_nonpersistent_flags+=("--provider=")
    local_nonpersistent_flags+=("-r")
    flags+=("--rev=")
    two_word_flags+=("--rev")
    local_nonpersistent_flags+=("--rev")
    local_nonpersistent_flags+=("--rev=")
    flags+=("--version=")
    two_word_flags+=("--version")
    two_word_flags+=("-v")
    local_nonpersistent_flags+=("--version")
    local_nonpersistent_flags+=("--version=")
    local_nonpersistent_flags+=("-v")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_flag+=("--name=")
    must_have_one_flag+=("-n")
    must_have_one_flag+=("--version=")
    must_have_one_flag+=("-v")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_export_api-product()
{
    last_command="apictl_export_api-product"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--latest")
    local_nonpersistent_flags+=("--latest")
    flags+=("--name=")
    two_word_flags+=("--name")
    two_word_flags+=("-n")
    local_nonpersistent_flags+=("--name")
    local_nonpersistent_flags+=("--name=")
    local_nonpersistent_flags+=("-n")
    flags+=("--preserve-status")
    local_nonpersistent_flags+=("--preserve-status")
    flags+=("--provider=")
    two_word_flags+=("--provider")
    two_word_flags+=("-r")
    local_nonpersistent_flags+=("--provider")
    local_nonpersistent_flags+=("--provider=")
    local_nonpersistent_flags+=("-r")
    flags+=("--rev=")
    two_word_flags+=("--rev")
    local_nonpersistent_flags+=("--rev")
    local_nonpersistent_flags+=("--rev=")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_flag+=("--name=")
    must_have_one_flag+=("-n")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_export_apis()
{
    last_command="apictl_export_apis"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--all")
    local_nonpersistent_flags+=("--all")
    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--force")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--preserve-status")
    local_nonpersistent_flags+=("--preserve-status")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_export_app()
{
    last_command="apictl_export_app"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--name=")
    two_word_flags+=("--name")
    two_word_flags+=("-n")
    local_nonpersistent_flags+=("--name")
    local_nonpersistent_flags+=("--name=")
    local_nonpersistent_flags+=("-n")
    flags+=("--owner=")
    two_word_flags+=("--owner")
    two_word_flags+=("-o")
    local_nonpersistent_flags+=("--owner")
    local_nonpersistent_flags+=("--owner=")
    local_nonpersistent_flags+=("-o")
    flags+=("--with-keys")
    local_nonpersistent_flags+=("--with-keys")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_flag+=("--name=")
    must_have_one_flag+=("-n")
    must_have_one_flag+=("--owner=")
    must_have_one_flag+=("-o")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_export_help()
{
    last_command="apictl_export_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_export()
{
    last_command="apictl_export"

    command_aliases=()

    commands=()
    commands+=("api")
    commands+=("api-product")
    commands+=("apis")
    commands+=("app")
    commands+=("help")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_gen_deployment-dir()
{
    last_command="apictl_gen_deployment-dir"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--destination=")
    two_word_flags+=("--destination")
    two_word_flags+=("-d")
    local_nonpersistent_flags+=("--destination")
    local_nonpersistent_flags+=("--destination=")
    local_nonpersistent_flags+=("-d")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--source=")
    two_word_flags+=("--source")
    two_word_flags+=("-s")
    local_nonpersistent_flags+=("--source")
    local_nonpersistent_flags+=("--source=")
    local_nonpersistent_flags+=("-s")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--source=")
    must_have_one_flag+=("-s")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_gen_help()
{
    last_command="apictl_gen_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_gen()
{
    last_command="apictl_gen"

    command_aliases=()

    commands=()
    commands+=("deployment-dir")
    commands+=("help")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_get_api-logging()
{
    last_command="apictl_get_api-logging"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--api-id=")
    two_word_flags+=("--api-id")
    two_word_flags+=("-i")
    local_nonpersistent_flags+=("--api-id")
    local_nonpersistent_flags+=("--api-id=")
    local_nonpersistent_flags+=("-i")
    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--tenant-domain=")
    two_word_flags+=("--tenant-domain")
    local_nonpersistent_flags+=("--tenant-domain")
    local_nonpersistent_flags+=("--tenant-domain=")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_get_api-product-revisions()
{
    last_command="apictl_get_api-product-revisions"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--name=")
    two_word_flags+=("--name")
    two_word_flags+=("-n")
    local_nonpersistent_flags+=("--name")
    local_nonpersistent_flags+=("--name=")
    local_nonpersistent_flags+=("-n")
    flags+=("--provider=")
    two_word_flags+=("--provider")
    two_word_flags+=("-r")
    local_nonpersistent_flags+=("--provider")
    local_nonpersistent_flags+=("--provider=")
    local_nonpersistent_flags+=("-r")
    flags+=("--query=")
    two_word_flags+=("--query")
    two_word_flags+=("-q")
    local_nonpersistent_flags+=("--query")
    local_nonpersistent_flags+=("--query=")
    local_nonpersistent_flags+=("-q")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_flag+=("--name=")
    must_have_one_flag+=("-n")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_get_api-products()
{
    last_command="apictl_get_api-products"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--limit=")
    two_word_flags+=("--limit")
    two_word_flags+=("-l")
    local_nonpersistent_flags+=("--limit")
    local_nonpersistent_flags+=("--limit=")
    local_nonpersistent_flags+=("-l")
    flags+=("--query=")
    two_word_flags+=("--query")
    two_word_flags+=("-q")
    local_nonpersistent_flags+=("--query")
    local_nonpersistent_flags+=("--query=")
    local_nonpersistent_flags+=("-q")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_get_api-revisions()
{
    last_command="apictl_get_api-revisions"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--name=")
    two_word_flags+=("--name")
    two_word_flags+=("-n")
    local_nonpersistent_flags+=("--name")
    local_nonpersistent_flags+=("--name=")
    local_nonpersistent_flags+=("-n")
    flags+=("--provider=")
    two_word_flags+=("--provider")
    two_word_flags+=("-r")
    local_nonpersistent_flags+=("--provider")
    local_nonpersistent_flags+=("--provider=")
    local_nonpersistent_flags+=("-r")
    flags+=("--query=")
    two_word_flags+=("--query")
    two_word_flags+=("-q")
    local_nonpersistent_flags+=("--query")
    local_nonpersistent_flags+=("--query=")
    local_nonpersistent_flags+=("-q")
    flags+=("--version=")
    two_word_flags+=("--version")
    two_word_flags+=("-v")
    local_nonpersistent_flags+=("--version")
    local_nonpersistent_flags+=("--version=")
    local_nonpersistent_flags+=("-v")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_flag+=("--name=")
    must_have_one_flag+=("-n")
    must_have_one_flag+=("--version=")
    must_have_one_flag+=("-v")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_get_apis()
{
    last_command="apictl_get_apis"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--limit=")
    two_word_flags+=("--limit")
    two_word_flags+=("-l")
    local_nonpersistent_flags+=("--limit")
    local_nonpersistent_flags+=("--limit=")
    local_nonpersistent_flags+=("-l")
    flags+=("--query=")
    two_word_flags+=("--query")
    two_word_flags+=("-q")
    local_nonpersistent_flags+=("--query")
    local_nonpersistent_flags+=("--query=")
    local_nonpersistent_flags+=("-q")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_get_apps()
{
    last_command="apictl_get_apps"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--limit=")
    two_word_flags+=("--limit")
    two_word_flags+=("-l")
    local_nonpersistent_flags+=("--limit")
    local_nonpersistent_flags+=("--limit=")
    local_nonpersistent_flags+=("-l")
    flags+=("--owner=")
    two_word_flags+=("--owner")
    two_word_flags+=("-o")
    local_nonpersistent_flags+=("--owner")
    local_nonpersistent_flags+=("--owner=")
    local_nonpersistent_flags+=("-o")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_get_envs()
{
    last_command="apictl_get_envs"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_get_help()
{
    last_command="apictl_get_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_get_keys()
{
    last_command="apictl_get_keys"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--name=")
    two_word_flags+=("--name")
    two_word_flags+=("-n")
    local_nonpersistent_flags+=("--name")
    local_nonpersistent_flags+=("--name=")
    local_nonpersistent_flags+=("-n")
    flags+=("--provider=")
    two_word_flags+=("--provider")
    two_word_flags+=("-r")
    local_nonpersistent_flags+=("--provider")
    local_nonpersistent_flags+=("--provider=")
    local_nonpersistent_flags+=("-r")
    flags+=("--token=")
    two_word_flags+=("--token")
    two_word_flags+=("-t")
    local_nonpersistent_flags+=("--token")
    local_nonpersistent_flags+=("--token=")
    local_nonpersistent_flags+=("-t")
    flags+=("--version=")
    two_word_flags+=("--version")
    two_word_flags+=("-v")
    local_nonpersistent_flags+=("--version")
    local_nonpersistent_flags+=("--version=")
    local_nonpersistent_flags+=("-v")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_flag+=("--name=")
    must_have_one_flag+=("-n")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_get()
{
    last_command="apictl_get"

    command_aliases=()

    commands=()
    commands+=("api-logging")
    commands+=("api-product-revisions")
    commands+=("api-products")
    commands+=("api-revisions")
    commands+=("apis")
    commands+=("apps")
    commands+=("envs")
    commands+=("help")
    commands+=("keys")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_help()
{
    last_command="apictl_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_import_api()
{
    last_command="apictl_import_api"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--file=")
    two_word_flags+=("--file")
    two_word_flags+=("-f")
    local_nonpersistent_flags+=("--file")
    local_nonpersistent_flags+=("--file=")
    local_nonpersistent_flags+=("-f")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--params=")
    two_word_flags+=("--params")
    local_nonpersistent_flags+=("--params")
    local_nonpersistent_flags+=("--params=")
    flags+=("--preserve-provider")
    local_nonpersistent_flags+=("--preserve-provider")
    flags+=("--rotate-revision")
    local_nonpersistent_flags+=("--rotate-revision")
    flags+=("--skip-cleanup")
    local_nonpersistent_flags+=("--skip-cleanup")
    flags+=("--skip-deployments")
    local_nonpersistent_flags+=("--skip-deployments")
    flags+=("--update")
    local_nonpersistent_flags+=("--update")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_flag+=("--file=")
    must_have_one_flag+=("-f")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_import_api-product()
{
    last_command="apictl_import_api-product"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--file=")
    two_word_flags+=("--file")
    two_word_flags+=("-f")
    local_nonpersistent_flags+=("--file")
    local_nonpersistent_flags+=("--file=")
    local_nonpersistent_flags+=("-f")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--import-apis")
    local_nonpersistent_flags+=("--import-apis")
    flags+=("--params=")
    two_word_flags+=("--params")
    local_nonpersistent_flags+=("--params")
    local_nonpersistent_flags+=("--params=")
    flags+=("--preserve-provider")
    local_nonpersistent_flags+=("--preserve-provider")
    flags+=("--rotate-revision")
    local_nonpersistent_flags+=("--rotate-revision")
    flags+=("--skip-cleanup")
    local_nonpersistent_flags+=("--skip-cleanup")
    flags+=("--skip-deployments")
    local_nonpersistent_flags+=("--skip-deployments")
    flags+=("--update-api-product")
    local_nonpersistent_flags+=("--update-api-product")
    flags+=("--update-apis")
    local_nonpersistent_flags+=("--update-apis")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_flag+=("--file=")
    must_have_one_flag+=("-f")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_import_app()
{
    last_command="apictl_import_app"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--file=")
    two_word_flags+=("--file")
    two_word_flags+=("-f")
    local_nonpersistent_flags+=("--file")
    local_nonpersistent_flags+=("--file=")
    local_nonpersistent_flags+=("-f")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--owner=")
    two_word_flags+=("--owner")
    two_word_flags+=("-o")
    local_nonpersistent_flags+=("--owner")
    local_nonpersistent_flags+=("--owner=")
    local_nonpersistent_flags+=("-o")
    flags+=("--preserve-owner")
    local_nonpersistent_flags+=("--preserve-owner")
    flags+=("--skip-cleanup")
    local_nonpersistent_flags+=("--skip-cleanup")
    flags+=("--skip-keys")
    local_nonpersistent_flags+=("--skip-keys")
    flags+=("--skip-subscriptions")
    flags+=("-s")
    local_nonpersistent_flags+=("--skip-subscriptions")
    local_nonpersistent_flags+=("-s")
    flags+=("--update")
    local_nonpersistent_flags+=("--update")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_flag+=("--file=")
    must_have_one_flag+=("-f")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_import_help()
{
    last_command="apictl_import_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_import()
{
    last_command="apictl_import"

    command_aliases=()

    commands=()
    commands+=("api")
    commands+=("api-product")
    commands+=("app")
    commands+=("help")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_init()
{
    last_command="apictl_init"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--definition=")
    two_word_flags+=("--definition")
    two_word_flags+=("-d")
    local_nonpersistent_flags+=("--definition")
    local_nonpersistent_flags+=("--definition=")
    local_nonpersistent_flags+=("-d")
    flags+=("--force")
    flags+=("-f")
    local_nonpersistent_flags+=("--force")
    local_nonpersistent_flags+=("-f")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--initial-state=")
    two_word_flags+=("--initial-state")
    local_nonpersistent_flags+=("--initial-state")
    local_nonpersistent_flags+=("--initial-state=")
    flags+=("--oas=")
    two_word_flags+=("--oas")
    local_nonpersistent_flags+=("--oas")
    local_nonpersistent_flags+=("--oas=")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_k8s_add_api()
{
    last_command="apictl_k8s_add_api"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--file=")
    two_word_flags+=("--file")
    two_word_flags+=("-f")
    local_nonpersistent_flags+=("--file")
    local_nonpersistent_flags+=("--file=")
    local_nonpersistent_flags+=("-f")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--name=")
    two_word_flags+=("--name")
    two_word_flags+=("-n")
    local_nonpersistent_flags+=("--name")
    local_nonpersistent_flags+=("--name=")
    local_nonpersistent_flags+=("-n")
    flags+=("--namespace=")
    two_word_flags+=("--namespace")
    local_nonpersistent_flags+=("--namespace")
    local_nonpersistent_flags+=("--namespace=")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--file=")
    must_have_one_flag+=("-f")
    must_have_one_flag+=("--name=")
    must_have_one_flag+=("-n")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_k8s_add_help()
{
    last_command="apictl_k8s_add_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_k8s_add()
{
    last_command="apictl_k8s_add"

    command_aliases=()

    commands=()
    commands+=("api")
    commands+=("help")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_k8s_delete_api()
{
    last_command="apictl_k8s_delete_api"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--name=")
    two_word_flags+=("--name")
    two_word_flags+=("-n")
    local_nonpersistent_flags+=("--name")
    local_nonpersistent_flags+=("--name=")
    local_nonpersistent_flags+=("-n")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--name=")
    must_have_one_flag+=("-n")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_k8s_delete_help()
{
    last_command="apictl_k8s_delete_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_k8s_delete()
{
    last_command="apictl_k8s_delete"

    command_aliases=()

    commands=()
    commands+=("api")
    commands+=("help")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_k8s_gen_deployment-dir()
{
    last_command="apictl_k8s_gen_deployment-dir"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--destination=")
    two_word_flags+=("--destination")
    two_word_flags+=("-d")
    local_nonpersistent_flags+=("--destination")
    local_nonpersistent_flags+=("--destination=")
    local_nonpersistent_flags+=("-d")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--source=")
    two_word_flags+=("--source")
    two_word_flags+=("-s")
    local_nonpersistent_flags+=("--source")
    local_nonpersistent_flags+=("--source=")
    local_nonpersistent_flags+=("-s")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--source=")
    must_have_one_flag+=("-s")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_k8s_gen_help()
{
    last_command="apictl_k8s_gen_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_k8s_gen()
{
    last_command="apictl_k8s_gen"

    command_aliases=()

    commands=()
    commands+=("deployment-dir")
    commands+=("help")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_k8s_help()
{
    last_command="apictl_k8s_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_k8s_update_api()
{
    last_command="apictl_k8s_update_api"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--file=")
    two_word_flags+=("--file")
    two_word_flags+=("-f")
    local_nonpersistent_flags+=("--file")
    local_nonpersistent_flags+=("--file=")
    local_nonpersistent_flags+=("-f")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--name=")
    two_word_flags+=("--name")
    two_word_flags+=("-n")
    local_nonpersistent_flags+=("--name")
    local_nonpersistent_flags+=("--name=")
    local_nonpersistent_flags+=("-n")
    flags+=("--namespace=")
    two_word_flags+=("--namespace")
    local_nonpersistent_flags+=("--namespace")
    local_nonpersistent_flags+=("--namespace=")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--file=")
    must_have_one_flag+=("-f")
    must_have_one_flag+=("--name=")
    must_have_one_flag+=("-n")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_k8s_update_help()
{
    last_command="apictl_k8s_update_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_k8s_update()
{
    last_command="apictl_k8s_update"

    command_aliases=()

    commands=()
    commands+=("api")
    commands+=("help")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_k8s()
{
    last_command="apictl_k8s"

    command_aliases=()

    commands=()
    commands+=("add")
    commands+=("delete")
    commands+=("gen")
    commands+=("help")
    commands+=("update")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_login()
{
    last_command="apictl_login"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--password=")
    two_word_flags+=("--password")
    two_word_flags+=("-p")
    local_nonpersistent_flags+=("--password")
    local_nonpersistent_flags+=("--password=")
    local_nonpersistent_flags+=("-p")
    flags+=("--password-stdin")
    local_nonpersistent_flags+=("--password-stdin")
    flags+=("--username=")
    two_word_flags+=("--username")
    two_word_flags+=("-u")
    local_nonpersistent_flags+=("--username")
    local_nonpersistent_flags+=("--username=")
    local_nonpersistent_flags+=("-u")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_logout()
{
    last_command="apictl_logout"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mg_add_env()
{
    last_command="apictl_mg_add_env"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--adapter=")
    two_word_flags+=("--adapter")
    two_word_flags+=("-a")
    local_nonpersistent_flags+=("--adapter")
    local_nonpersistent_flags+=("--adapter=")
    local_nonpersistent_flags+=("-a")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--adapter=")
    must_have_one_flag+=("-a")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mg_add_help()
{
    last_command="apictl_mg_add_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_mg_add()
{
    last_command="apictl_mg_add"

    command_aliases=()

    commands=()
    commands+=("env")
    commands+=("help")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mg_deploy_api()
{
    last_command="apictl_mg_deploy_api"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--file=")
    two_word_flags+=("--file")
    two_word_flags+=("-f")
    local_nonpersistent_flags+=("--file")
    local_nonpersistent_flags+=("--file=")
    local_nonpersistent_flags+=("-f")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--override")
    flags+=("-o")
    local_nonpersistent_flags+=("--override")
    local_nonpersistent_flags+=("-o")
    flags+=("--skip-cleanup")
    local_nonpersistent_flags+=("--skip-cleanup")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_flag+=("--file=")
    must_have_one_flag+=("-f")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mg_deploy_help()
{
    last_command="apictl_mg_deploy_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_mg_deploy()
{
    last_command="apictl_mg_deploy"

    command_aliases=()

    commands=()
    commands+=("api")
    commands+=("help")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mg_get_apis()
{
    last_command="apictl_mg_get_apis"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--limit=")
    two_word_flags+=("--limit")
    two_word_flags+=("-l")
    local_nonpersistent_flags+=("--limit")
    local_nonpersistent_flags+=("--limit=")
    local_nonpersistent_flags+=("-l")
    flags+=("--query=")
    two_word_flags+=("--query")
    two_word_flags+=("-q")
    local_nonpersistent_flags+=("--query")
    local_nonpersistent_flags+=("--query=")
    local_nonpersistent_flags+=("-q")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mg_get_help()
{
    last_command="apictl_mg_get_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_mg_get()
{
    last_command="apictl_mg_get"

    command_aliases=()

    commands=()
    commands+=("apis")
    commands+=("help")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mg_help()
{
    last_command="apictl_mg_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_mg_login()
{
    last_command="apictl_mg_login"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--password=")
    two_word_flags+=("--password")
    two_word_flags+=("-p")
    local_nonpersistent_flags+=("--password")
    local_nonpersistent_flags+=("--password=")
    local_nonpersistent_flags+=("-p")
    flags+=("--password-stdin")
    local_nonpersistent_flags+=("--password-stdin")
    flags+=("--username=")
    two_word_flags+=("--username")
    two_word_flags+=("-u")
    local_nonpersistent_flags+=("--username")
    local_nonpersistent_flags+=("--username=")
    local_nonpersistent_flags+=("-u")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mg_logout()
{
    last_command="apictl_mg_logout"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mg_remove_env()
{
    last_command="apictl_mg_remove_env"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mg_remove_help()
{
    last_command="apictl_mg_remove_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_mg_remove()
{
    last_command="apictl_mg_remove"

    command_aliases=()

    commands=()
    commands+=("env")
    commands+=("help")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mg_undeploy_api()
{
    last_command="apictl_mg_undeploy_api"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--gateway-env=")
    two_word_flags+=("--gateway-env")
    two_word_flags+=("-g")
    local_nonpersistent_flags+=("--gateway-env")
    local_nonpersistent_flags+=("--gateway-env=")
    local_nonpersistent_flags+=("-g")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--name=")
    two_word_flags+=("--name")
    two_word_flags+=("-n")
    local_nonpersistent_flags+=("--name")
    local_nonpersistent_flags+=("--name=")
    local_nonpersistent_flags+=("-n")
    flags+=("--version=")
    two_word_flags+=("--version")
    two_word_flags+=("-v")
    local_nonpersistent_flags+=("--version")
    local_nonpersistent_flags+=("--version=")
    local_nonpersistent_flags+=("-v")
    flags+=("--vhost=")
    two_word_flags+=("--vhost")
    two_word_flags+=("-t")
    local_nonpersistent_flags+=("--vhost")
    local_nonpersistent_flags+=("--vhost=")
    local_nonpersistent_flags+=("-t")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_flag+=("--name=")
    must_have_one_flag+=("-n")
    must_have_one_flag+=("--version=")
    must_have_one_flag+=("-v")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mg_undeploy_help()
{
    last_command="apictl_mg_undeploy_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_mg_undeploy()
{
    last_command="apictl_mg_undeploy"

    command_aliases=()

    commands=()
    commands+=("api")
    commands+=("help")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mg()
{
    last_command="apictl_mg"

    command_aliases=()

    commands=()
    commands+=("add")
    commands+=("deploy")
    commands+=("get")
    commands+=("help")
    commands+=("login")
    commands+=("logout")
    commands+=("remove")
    commands+=("undeploy")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_activate_endpoint()
{
    last_command="apictl_mi_activate_endpoint"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_activate_help()
{
    last_command="apictl_mi_activate_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_mi_activate_message-processor()
{
    last_command="apictl_mi_activate_message-processor"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_activate_proxy-service()
{
    last_command="apictl_mi_activate_proxy-service"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_activate()
{
    last_command="apictl_mi_activate"

    command_aliases=()

    commands=()
    commands+=("endpoint")
    commands+=("help")
    commands+=("message-processor")
    commands+=("proxy-service")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_add_help()
{
    last_command="apictl_mi_add_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_mi_add_log-level()
{
    last_command="apictl_mi_add_log-level"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_add_role()
{
    last_command="apictl_mi_add_role"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_add_user()
{
    last_command="apictl_mi_add_user"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_add()
{
    last_command="apictl_mi_add"

    command_aliases=()

    commands=()
    commands+=("help")
    commands+=("log-level")
    commands+=("role")
    commands+=("user")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_deactivate_endpoint()
{
    last_command="apictl_mi_deactivate_endpoint"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_deactivate_help()
{
    last_command="apictl_mi_deactivate_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_mi_deactivate_message-processor()
{
    last_command="apictl_mi_deactivate_message-processor"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_deactivate_proxy-service()
{
    last_command="apictl_mi_deactivate_proxy-service"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_deactivate()
{
    last_command="apictl_mi_deactivate"

    command_aliases=()

    commands=()
    commands+=("endpoint")
    commands+=("help")
    commands+=("message-processor")
    commands+=("proxy-service")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_delete_help()
{
    last_command="apictl_mi_delete_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_mi_delete_role()
{
    last_command="apictl_mi_delete_role"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--domain=")
    two_word_flags+=("--domain")
    two_word_flags+=("-d")
    local_nonpersistent_flags+=("--domain")
    local_nonpersistent_flags+=("--domain=")
    local_nonpersistent_flags+=("-d")
    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_delete_user()
{
    last_command="apictl_mi_delete_user"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--domain=")
    two_word_flags+=("--domain")
    two_word_flags+=("-d")
    local_nonpersistent_flags+=("--domain")
    local_nonpersistent_flags+=("--domain=")
    local_nonpersistent_flags+=("-d")
    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_delete()
{
    last_command="apictl_mi_delete"

    command_aliases=()

    commands=()
    commands+=("help")
    commands+=("role")
    commands+=("user")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_get_apis()
{
    last_command="apictl_mi_get_apis"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_get_composite-apps()
{
    last_command="apictl_mi_get_composite-apps"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_get_connectors()
{
    last_command="apictl_mi_get_connectors"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_get_data-services()
{
    last_command="apictl_mi_get_data-services"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_get_endpoints()
{
    last_command="apictl_mi_get_endpoints"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_get_help()
{
    last_command="apictl_mi_get_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_mi_get_inbound-endpoints()
{
    last_command="apictl_mi_get_inbound-endpoints"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_get_local-entries()
{
    last_command="apictl_mi_get_local-entries"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_get_log-levels()
{
    last_command="apictl_mi_get_log-levels"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_get_logs()
{
    last_command="apictl_mi_get_logs"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--path=")
    two_word_flags+=("--path")
    two_word_flags+=("-p")
    local_nonpersistent_flags+=("--path")
    local_nonpersistent_flags+=("--path=")
    local_nonpersistent_flags+=("-p")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_get_message-processors()
{
    last_command="apictl_mi_get_message-processors"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_get_message-stores()
{
    last_command="apictl_mi_get_message-stores"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_get_proxy-services()
{
    last_command="apictl_mi_get_proxy-services"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_get_roles()
{
    last_command="apictl_mi_get_roles"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--domain=")
    two_word_flags+=("--domain")
    two_word_flags+=("-d")
    local_nonpersistent_flags+=("--domain")
    local_nonpersistent_flags+=("--domain=")
    local_nonpersistent_flags+=("-d")
    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_get_sequences()
{
    last_command="apictl_mi_get_sequences"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_get_tasks()
{
    last_command="apictl_mi_get_tasks"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_get_templates()
{
    last_command="apictl_mi_get_templates"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_get_transaction-counts()
{
    last_command="apictl_mi_get_transaction-counts"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_get_transaction-reports()
{
    last_command="apictl_mi_get_transaction-reports"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--path=")
    two_word_flags+=("--path")
    two_word_flags+=("-p")
    local_nonpersistent_flags+=("--path")
    local_nonpersistent_flags+=("--path=")
    local_nonpersistent_flags+=("-p")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_get_users()
{
    last_command="apictl_mi_get_users"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--domain=")
    two_word_flags+=("--domain")
    two_word_flags+=("-d")
    local_nonpersistent_flags+=("--domain")
    local_nonpersistent_flags+=("--domain=")
    local_nonpersistent_flags+=("-d")
    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--pattern=")
    two_word_flags+=("--pattern")
    two_word_flags+=("-p")
    local_nonpersistent_flags+=("--pattern")
    local_nonpersistent_flags+=("--pattern=")
    local_nonpersistent_flags+=("-p")
    flags+=("--role=")
    two_word_flags+=("--role")
    two_word_flags+=("-r")
    local_nonpersistent_flags+=("--role")
    local_nonpersistent_flags+=("--role=")
    local_nonpersistent_flags+=("-r")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_get()
{
    last_command="apictl_mi_get"

    command_aliases=()

    commands=()
    commands+=("apis")
    commands+=("composite-apps")
    commands+=("connectors")
    commands+=("data-services")
    commands+=("endpoints")
    commands+=("help")
    commands+=("inbound-endpoints")
    commands+=("local-entries")
    commands+=("log-levels")
    commands+=("logs")
    commands+=("message-processors")
    commands+=("message-stores")
    commands+=("proxy-services")
    commands+=("roles")
    commands+=("sequences")
    commands+=("tasks")
    commands+=("templates")
    commands+=("transaction-counts")
    commands+=("transaction-reports")
    commands+=("users")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_help()
{
    last_command="apictl_mi_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_mi_login()
{
    last_command="apictl_mi_login"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--password=")
    two_word_flags+=("--password")
    two_word_flags+=("-p")
    local_nonpersistent_flags+=("--password")
    local_nonpersistent_flags+=("--password=")
    local_nonpersistent_flags+=("-p")
    flags+=("--password-stdin")
    local_nonpersistent_flags+=("--password-stdin")
    flags+=("--username=")
    two_word_flags+=("--username")
    two_word_flags+=("-u")
    local_nonpersistent_flags+=("--username")
    local_nonpersistent_flags+=("--username=")
    local_nonpersistent_flags+=("-u")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_logout()
{
    last_command="apictl_mi_logout"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_update_hashicorp-secret()
{
    last_command="apictl_mi_update_hashicorp-secret"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_update_help()
{
    last_command="apictl_mi_update_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_mi_update_log-level()
{
    last_command="apictl_mi_update_log-level"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_update_user()
{
    last_command="apictl_mi_update_user"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi_update()
{
    last_command="apictl_mi_update"

    command_aliases=()

    commands=()
    commands+=("hashicorp-secret")
    commands+=("help")
    commands+=("log-level")
    commands+=("user")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_mi()
{
    last_command="apictl_mi"

    command_aliases=()

    commands=()
    commands+=("activate")
    commands+=("add")
    commands+=("deactivate")
    commands+=("delete")
    commands+=("get")
    commands+=("help")
    commands+=("login")
    commands+=("logout")
    commands+=("update")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_remove_env()
{
    last_command="apictl_remove_env"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_remove_help()
{
    last_command="apictl_remove_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_remove()
{
    last_command="apictl_remove"

    command_aliases=()

    commands=()
    commands+=("env")
    commands+=("help")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_secret_create()
{
    last_command="apictl_secret_create"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--cipher=")
    two_word_flags+=("--cipher")
    two_word_flags+=("-c")
    local_nonpersistent_flags+=("--cipher")
    local_nonpersistent_flags+=("--cipher=")
    local_nonpersistent_flags+=("-c")
    flags+=("--from-file=")
    two_word_flags+=("--from-file")
    two_word_flags+=("-f")
    local_nonpersistent_flags+=("--from-file")
    local_nonpersistent_flags+=("--from-file=")
    local_nonpersistent_flags+=("-f")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--output=")
    two_word_flags+=("--output")
    two_word_flags+=("-o")
    local_nonpersistent_flags+=("--output")
    local_nonpersistent_flags+=("--output=")
    local_nonpersistent_flags+=("-o")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_secret_help()
{
    last_command="apictl_secret_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_secret_init()
{
    last_command="apictl_secret_init"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_secret()
{
    last_command="apictl_secret"

    command_aliases=()

    commands=()
    commands+=("create")
    commands+=("help")
    commands+=("init")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_set_api-logging()
{
    last_command="apictl_set_api-logging"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--api-id=")
    two_word_flags+=("--api-id")
    two_word_flags+=("-i")
    local_nonpersistent_flags+=("--api-id")
    local_nonpersistent_flags+=("--api-id=")
    local_nonpersistent_flags+=("-i")
    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--log-level=")
    two_word_flags+=("--log-level")
    local_nonpersistent_flags+=("--log-level")
    local_nonpersistent_flags+=("--log-level=")
    flags+=("--tenant-domain=")
    two_word_flags+=("--tenant-domain")
    local_nonpersistent_flags+=("--tenant-domain")
    local_nonpersistent_flags+=("--tenant-domain=")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--api-id=")
    must_have_one_flag+=("-i")
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_flag+=("--log-level=")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_set_help()
{
    last_command="apictl_set_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_set()
{
    last_command="apictl_set"

    command_aliases=()

    commands=()
    commands+=("api-logging")
    commands+=("help")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--export-directory=")
    two_word_flags+=("--export-directory")
    local_nonpersistent_flags+=("--export-directory")
    local_nonpersistent_flags+=("--export-directory=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--http-request-timeout=")
    two_word_flags+=("--http-request-timeout")
    local_nonpersistent_flags+=("--http-request-timeout")
    local_nonpersistent_flags+=("--http-request-timeout=")
    flags+=("--tls-renegotiation-mode=")
    two_word_flags+=("--tls-renegotiation-mode")
    local_nonpersistent_flags+=("--tls-renegotiation-mode")
    local_nonpersistent_flags+=("--tls-renegotiation-mode=")
    flags+=("--vcs-config-path=")
    two_word_flags+=("--vcs-config-path")
    local_nonpersistent_flags+=("--vcs-config-path")
    local_nonpersistent_flags+=("--vcs-config-path=")
    flags+=("--vcs-deletion-enabled")
    local_nonpersistent_flags+=("--vcs-deletion-enabled")
    flags+=("--vcs-deployment-repo-path=")
    two_word_flags+=("--vcs-deployment-repo-path")
    local_nonpersistent_flags+=("--vcs-deployment-repo-path")
    local_nonpersistent_flags+=("--vcs-deployment-repo-path=")
    flags+=("--vcs-source-repo-path=")
    two_word_flags+=("--vcs-source-repo-path")
    local_nonpersistent_flags+=("--vcs-source-repo-path")
    local_nonpersistent_flags+=("--vcs-source-repo-path=")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_undeploy_api()
{
    last_command="apictl_undeploy_api"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--gateway-env=")
    two_word_flags+=("--gateway-env")
    two_word_flags+=("-g")
    local_nonpersistent_flags+=("--gateway-env")
    local_nonpersistent_flags+=("--gateway-env=")
    local_nonpersistent_flags+=("-g")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--name=")
    two_word_flags+=("--name")
    two_word_flags+=("-n")
    local_nonpersistent_flags+=("--name")
    local_nonpersistent_flags+=("--name=")
    local_nonpersistent_flags+=("-n")
    flags+=("--provider=")
    two_word_flags+=("--provider")
    two_word_flags+=("-r")
    local_nonpersistent_flags+=("--provider")
    local_nonpersistent_flags+=("--provider=")
    local_nonpersistent_flags+=("-r")
    flags+=("--rev=")
    two_word_flags+=("--rev")
    local_nonpersistent_flags+=("--rev")
    local_nonpersistent_flags+=("--rev=")
    flags+=("--version=")
    two_word_flags+=("--version")
    two_word_flags+=("-v")
    local_nonpersistent_flags+=("--version")
    local_nonpersistent_flags+=("--version=")
    local_nonpersistent_flags+=("-v")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_flag+=("--name=")
    must_have_one_flag+=("-n")
    must_have_one_flag+=("--rev=")
    must_have_one_flag+=("--version=")
    must_have_one_flag+=("-v")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_undeploy_api-product()
{
    last_command="apictl_undeploy_api-product"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--gateway-env=")
    two_word_flags+=("--gateway-env")
    two_word_flags+=("-g")
    local_nonpersistent_flags+=("--gateway-env")
    local_nonpersistent_flags+=("--gateway-env=")
    local_nonpersistent_flags+=("-g")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--name=")
    two_word_flags+=("--name")
    two_word_flags+=("-n")
    local_nonpersistent_flags+=("--name")
    local_nonpersistent_flags+=("--name=")
    local_nonpersistent_flags+=("-n")
    flags+=("--provider=")
    two_word_flags+=("--provider")
    two_word_flags+=("-r")
    local_nonpersistent_flags+=("--provider")
    local_nonpersistent_flags+=("--provider=")
    local_nonpersistent_flags+=("-r")
    flags+=("--rev=")
    two_word_flags+=("--rev")
    local_nonpersistent_flags+=("--rev")
    local_nonpersistent_flags+=("--rev=")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_flag+=("--name=")
    must_have_one_flag+=("-n")
    must_have_one_flag+=("--rev=")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_undeploy_help()
{
    last_command="apictl_undeploy_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_undeploy()
{
    last_command="apictl_undeploy"

    command_aliases=()

    commands=()
    commands+=("api")
    commands+=("api-product")
    commands+=("help")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_vcs_deploy()
{
    last_command="apictl_vcs_deploy"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--skip-rollback")
    local_nonpersistent_flags+=("--skip-rollback")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_vcs_help()
{
    last_command="apictl_vcs_help"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    has_completion_function=1
    noun_aliases=()
}

_apictl_vcs_init()
{
    last_command="apictl_vcs_init"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--force")
    flags+=("-f")
    local_nonpersistent_flags+=("--force")
    local_nonpersistent_flags+=("-f")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_vcs_status()
{
    last_command="apictl_vcs_status"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--environment=")
    two_word_flags+=("--environment")
    two_word_flags+=("-e")
    local_nonpersistent_flags+=("--environment")
    local_nonpersistent_flags+=("--environment=")
    local_nonpersistent_flags+=("-e")
    flags+=("--format=")
    two_word_flags+=("--format")
    local_nonpersistent_flags+=("--format")
    local_nonpersistent_flags+=("--format=")
    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_flag+=("--environment=")
    must_have_one_flag+=("-e")
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_vcs()
{
    last_command="apictl_vcs"

    command_aliases=()

    commands=()
    commands+=("deploy")
    commands+=("help")
    commands+=("init")
    commands+=("status")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_version()
{
    last_command="apictl_version"

    command_aliases=()

    commands=()

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

_apictl_root_command()
{
    last_command="apictl"

    command_aliases=()

    commands=()
    commands+=("add")
    commands+=("aws")
    commands+=("bundle")
    commands+=("change-status")
    commands+=("delete")
    commands+=("export")
    commands+=("gen")
    commands+=("get")
    commands+=("help")
    commands+=("import")
    commands+=("init")
    commands+=("k8s")
    commands+=("login")
    commands+=("logout")
    commands+=("mg")
    commands+=("mi")
    commands+=("remove")
    commands+=("secret")
    commands+=("set")
    commands+=("undeploy")
    commands+=("vcs")
    commands+=("version")

    flags=()
    two_word_flags=()
    local_nonpersistent_flags=()
    flags_with_completion=()
    flags_completion=()

    flags+=("--help")
    flags+=("-h")
    local_nonpersistent_flags+=("--help")
    local_nonpersistent_flags+=("-h")
    flags+=("--insecure")
    flags+=("-k")
    flags+=("--verbose")

    must_have_one_flag=()
    must_have_one_noun=()
    noun_aliases=()
}

__start_apictl()
{
    local cur prev words cword
    declare -A flaghash 2>/dev/null || :
    declare -A aliashash 2>/dev/null || :
    if declare -F _init_completion >/dev/null 2>&1; then
        _init_completion -s || return
    else
        __apictl_init_completion -n "=" || return
    fi

    local c=0
    local flags=()
    local two_word_flags=()
    local local_nonpersistent_flags=()
    local flags_with_completion=()
    local flags_completion=()
    local commands=("apictl")
    local must_have_one_flag=()
    local must_have_one_noun=()
    local has_completion_function
    local last_command
    local nouns=()

    __apictl_handle_word
}

if [[ $(type -t compopt) = "builtin" ]]; then
    complete -o default -F __start_apictl apictl
else
    complete -o default -o nospace -F __start_apictl apictl
fi

# ex: ts=4 sw=4 et filetype=sh
