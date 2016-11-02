#VIM JAVA IMPORT MANAGER
###INSTALL

use vbundle :

    add follow line to your vimfiles :

    Plugin 'abcdnned/java-import-manager'

    restart vim and call PluginInstall command.

manually :

    put java.vim in the ftplugin folder under vimfiles directory.

###USAGE

    use <Leader>1i to insert import statement on the right position and press 'j to go back. 

###COMMAND

    JIMPrepareImport  : move cursor to the right position.

    JIMSortImport     : sort import statements.

    JIMDeclarePackage : rewrite first line to package info.

###MAPPING

    <Leader>1i : JIMPrepareImport

    <Leader>1s : JIMSortImport

    <Leader>1p : JIMDeclarePackage

###OPTION

    g:jim_root : root package of you project, default is 'java'.
