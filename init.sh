#!/bin/sh

copyGitHooksFiles=1     # copy git hooks file
chmodGitHooks=1         # chmod git hooks dir
nodeVersion=$(node -v)
npmVersion=$(npm -v)
# echo 字符画
function printAsciiText(){
    sh ./bin/text.sh $1
}

# 验证执行结果，如果失败则中断运行
function checkExecResult(){
    result=$1
    lineNum=$2
    message=$3
    
    if [ $result != 0 ]; then
        echo "\n[FAIL] L${lineNum} $message\n"

        printAsciiText fail

        exit 1;
    fi
}

sh 'printenv'
echo "node $nodeVersion\nnpm $npmVersion\n$HOME"

# copy githook files
if [ $copyGitHooksFiles == 1 ]; then
    echo "\n copy git hooks files"
    cp ./hook/* ./.git/hooks/
    checkExecResult $? 72 copy_githook_files_error
fi

# chmod git hooks dir
if [ $chmodGitHooks == 1 ]; then
    echo "\n chmod git hooks dir"
    chmod -R 777 ./.git/hooks/
    checkExecResult $? 79 chmod_git_hooks_dir_error
fi

printAsciiText success

exit 0;
