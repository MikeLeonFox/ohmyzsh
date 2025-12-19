# ~/.oh-my-zsh/custom/01-env.zsh
# Environment setup and initialization

# Powerlevel10k instant prompt compatibility - MUST BE FIRST
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# ===============================
# CLEAR CONFLICTING ALIASES FIRST
# ===============================
# Clear any conflicting aliases from oh-my-zsh plugins BEFORE defining functions
{
    unalias gcp gcpp gclone gnew gundo gsync gfeat gfix gdocs gstyle grefactor gtest 2>/dev/null || true
    unalias gpush gpull gsquash gcleanup gfzf glog gblame 2>/dev/null || true
    unalias gwip gunwip gwrongbranch gnuke gcompare gback gmergetool 2>/dev/null || true
    unalias mkcd take up fcd proj bookmark listbookmarks 2>/dev/null || true
    unalias ff fdir ffile ftype extract archive backup large duplicates info 2>/dev/null || true
    unalias dbash dsh dcleanup dwatch dstats kexec kpf klog 2>/dev/null || true
    unalias psg ports sysinfo topcpu topmem netdiag 2>/dev/null || true
    unalias weather genpass qrcode shorten serve killport fkill 2>/dev/null || true
    unalias note notes searchnotes clearnotes task tasks taskdone 2>/dev/null || true
    unalias deps devdeps scripts loc todos testfile format 2>/dev/null || true
    unalias httpget httppost api myip portscan json search replace 2>/dev/null || true
    unalias clean hosts fstab sudoers own 2>/dev/null || true
    unalias kernel now nowdate timestamp week calc random listening 2>/dev/null || true
    unalias reload rl c cls clr h hg dirsize help 2>/dev/null || true
    unalias pw prun psize pinfo pcreate pworkspace pcd 2>/dev/null || true
} &>/dev/null

# Flag to indicate aliases are loaded
export ALIASES_LOADED=1
