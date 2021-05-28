#define loader "{app}\Sybaris\Loader"
#define plugins "{app}\Sybaris\Plugins"
#define gamedata "{app}\Sybaris\GameData"
#define unityinjector "{app}\Sybaris\Plugins\UnityInjector"
#define bepin "{app}\BepinEx"
#define syb "{app}\Sybaris"
#define scripts "{app}\scripts"
#define mods "{app}\Mods"
#define docs "{app}\LMMT Documentation"

#define srcPlugins "LMMT\Plugins"
#define srcPatchers "LMMT\Patchers"
#define srcSybaris "LMMT\Loader\Sybaris"
#define srcBepinEx "LMMT\Loader\BepinEx"
#define srcMisc "LMMT\Misc"
#define srcDocumentation "LMMT\Documentation"

[InstallDelete]

Type:filesandordirs; Name: "{#loader}"; Tasks:clean/deleteold;
Type:filesandordirs; Name: "{#plugins}"; Tasks:clean/deleteold;
Type:filesandordirs; Name: "{#syb}\Poses"; Tasks:clean/deleteold;
Type:filesandordirs; Name: "{#syb}\Preset"; Tasks:clean/deleteold;
Type:filesandordirs; Name: "{#syb}\IgnoreMenus.txt"; Tasks:clean/deleteold;
Type:filesandordirs; Name: "opengl32.dll"; Tasks:clean/deleteold;
;Syb ^^
Type:filesandordirs; Name: "{#bepin}"; Tasks:clean/deleteold;
Type:filesandordirs; Name: "{app}\scripts"; Tasks:clean/deleteold;
Type:filesandordirs; Name: "{app}\doorstop_config.ini"; Tasks:clean/deleteold;
Type:filesandordirs; Name: "{app}\winhttp.dll"; Tasks:clean/deleteold;
Type:filesandordirs; Name: "{app}\version.dll"; Tasks:clean/deleteold;
;Bepin ^^
Type:filesandordirs; Name: "{app}\EngSybarisArcEditor.exe"; Tasks:clean/deleteold;
Type:filesandordirs; Name: "{app}\IMGUITranslationLoader"; Tasks:clean/deleteold;
Type:filesandordirs; Name: "{#docs}"; Tasks:clean/deleteold;
    
Type:filesandordirs; Name: "{#gamedata}\[CMI]Uncensors"; Tasks:clean/deleteold/mods;
Type:filesandordirs; Name: "{#gamedata}\[CMI]EmotionalEars"; Tasks:clean/deleteold/mods;
Type:filesandordirs; Name: "{#gamedata}\[CMI]VYM Files"; Tasks:clean/deleteold/mods;
Type:filesandordirs; Name: "{#gamedata}\MultipleMaidsPose"; Tasks:clean/deleteold/mods;
Type:filesandordirs; Name: "{#gamedata}\Samples"; Tasks:clean/deleteold/mods;

Type:filesandordirs; Name: "{app}\OldInstall*"; Tasks:clean/deleteold/old;

Type:filesandordirs; Name: "{app}\Mod\[CMI]GameData Link*"; Tasks:Correct/delsym OR delsym;


[Run]
Filename: "{cmd}"; Description:Make a SymLink between Mods folder and Sybaris\GameData; Parameters: "/C mklink /D ""{app}\Mod\[CMI]GameData Link"" ""{app}\Sybaris\GameData"""; Components:Loader/BepinEx; Flags: runascurrentuser; Tasks:Correct\Mod
[/Run]


[Files]

;Modloaders stuffs
Source: "{#SrcBepinEx}\Core\Main\*"; DestDir: "{app}"; Components: Loader/bepinEX; Flags: ignoreversion recursesubdirs createallsubdirs

Source: "{#SrcBepinEx}\Core\x64\*"; DestDir: "{app}"; Components: Loader/bepinEX/x64; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcBepinEx}\Core\x86\*"; DestDir: "{app}"; Components: Loader/bepinEX/x86; Flags: ignoreversion recursesubdirs createallsubdirs

Source: "{#srcSybaris}\Core\Main\*"; DestDir: "{app}"; Components: Loader/Sybaris; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#srcSybaris}\Core\x64\*"; DestDir: "{app}"; Components: Loader/Sybaris/x64; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#srcSybaris}\Core\x86\*"; DestDir: "{app}"; Components: Loader/Sybaris/x86; Flags: ignoreversion recursesubdirs createallsubdirs

;Loader dependent translators

Source: "{#SrcBepinEx}\ResourceRedirector\*"; DestDir: "{app}"; Components: Loader/bepinEX/Translations/Resredir; Flags: ignoreversion recursesubdirs createallsubdirs
	Source: "{#SrcBepinEx}\Xuat\*"; DestDir: "{app}"; Components: Loader/bepinEX/Translations/resredir/xuat; Flags: ignoreversion recursesubdirs createallsubdirs

Source: "{#srcSybaris}\Xuat\*"; DestDir: "{app}"; Components: Loader/Sybaris/Translations/xuat; Flags: ignoreversion recursesubdirs createallsubdirs

;Script Loader
Source: "{#SrcBepinEx}\ScriptLoader\*"; DestDir: "{#bepin}\plugins"; Components: Loader/bepinEX/scriptloader; Flags: ignoreversion recursesubdirs createallsubdirs
	Source: "{#SrcBepinEx}\ScriptLoader\Scripts\wrapmode\*"; DestDir: "{#scripts}"; Components: Loader/bepinEX/scriptloader/wrapmode; Flags: ignoreversion recursesubdirs createallsubdirs
	Source: "{#SrcBepinEx}\ScriptLoader\Scripts\modpriority\*"; DestDir: "{#scripts}"; Components: Loader/bepinEX/scriptloader/modpriority; Flags: ignoreversion recursesubdirs createallsubdirs


;Patchers
Source: "{#SrcPatchers}\IMGUITranslator\Core\*"; DestDir: "{app}"; Components: Patchers/imgui; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPatchers}\IMGUITranslator\ExtraTranslationFiles\*"; DestDir: "{app}\IMGUITranslationLoader\IMGUIStrings"; Components: Patchers/imgui/translations; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPatchers}\smoothanim\CM3D2.SmoothAnimation.Patcher.dll"; DestDir: "{#loader}"; Components: Patchers/smoothanim; Flags: ignoreversion
Source: "{#SrcPatchers}\smoothanim\CM3D2.SmoothAnimation.Managed.dll"; DestDir: "{#loader}"; Components: Patchers/smoothanim; Flags: ignoreversion
Source: "{#SrcPatchers}\SkinRes\*"; DestDir: "{#loader}"; Components: Patchers/SkinRes; Flags: ignoreversion recursesubdirs
Source: "{#SrcPatchers}\COMShader\*"; DestDir: "{#loader}"; Components: Patchers/COMShader; Flags: ignoreversion recursesubdirs
Source: "{#SrcPatchers}\CUFix\*"; DestDir: "{#loader}"; Components: Patchers/CUFix; Flags: ignoreversion recursesubdirs
Source: "{#SrcPatchers}\smoothanim\UnityInjector\*"; DestDir: "{#unityinjector}"; Components: Patchers/smoothanim; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPatchers}\ExternalSave\*"; DestDir: "{#loader}"; Components: Patchers/extsave; Flags: ignoreversion recursesubdirs createallsubdirs
  Source: "{#SrcPlugins}\MaidVoice\CM3D2.MaidVoicePitch.Patcher.dll"; DestDir: "{#loader}"; Components: Patchers/extsave/maidvoice; Flags: ignoreversion recursesubdirs
  Source: "{#SrcPlugins}\MaidVoice\CM3D2.MaidVoicePitch.Managed.dll"; DestDir: "{#loader}"; Components: Patchers/extsave/maidvoice; Flags: ignoreversion  recursesubdirs
  Source: "{#SrcPlugins}\MaidVoice\UnityInjector\*"; DestDir: "{#unityinjector}"; Components: Patchers/extsave/maidvoice; Flags: ignoreversion recursesubdirs createallsubdirs
    Source: "{#SrcPlugins}\AddMod\*"; DestDir: "{#plugins}"; Components: Patchers/extsave/maidvoice/addmod; Flags: ignoreversion recursesubdirs createallsubdirs
      Source: "{#SrcPlugins}\distortcorrect\UnityInjector\*"; DestDir: "{#unityinjector}"; Components: Patchers/extsave/maidvoice/addmod/distort; Flags: ignoreversion recursesubdirs createallsubdirs
      Source: "{#SrcPlugins}\distortcorrect\CM3D2.DistortCorrect.Managed.dll"; DestDir: "{#loader}"; Components: Patchers/extsave/maidvoice/addmod/distort; Flags: ignoreversion
      Source: "{#SrcPlugins}\distortcorrect\CM3D2.DistortCorrect.Patcher.dll"; DestDir: "{#loader}"; Components: Patchers/extsave/maidvoice/addmod/distort; Flags: ignoreversion


;Source: "{#SrcPatchers}\BodyParam\*"; DestDir: "{#syb}"; Components: Patchers/BodyParam; Flags: ignoreversion recursesubdirs
Source: "{#SrcPatchers}\EditUtil\*"; DestDir: "{#syb}"; Components: Patchers/EditUtil; Flags: ignoreversion recursesubdirs
;Source: "{#SrcPatchers}\HitImprov\*"; DestDir: "{#loader}"; Components: Patchers/HitImprov; Flags: ignoreversion recursesubdirs
Source: "{#SrcPatchers}\FaceType\*"; DestDir: "{#loader}"; Components: Patchers/facetype; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPatchers}\FastFade\*"; DestDir: "{#loader}"; Components: Patchers/fastfade; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPatchers}\NameExt\*"; DestDir: "{#loader}"; Components: Patchers/namext; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPatchers}\NeighUncen\*"; DestDir: "{#loader}"; Components: Patchers/NeighUncen; Flags: ignoreversion recursesubdirs createallsubdirs
;Source: "{#SrcPatchers}\prelabellite\*"; DestDir: "{#loader}"; Components: Patchers/prelabellite; Flags: ignoreversion recursesubdirs createallsubdirs


;Plugins
Source: "{#SrcPlugins}\ACCex\*"; DestDir: "{#plugins}"; Components: plugins/accex; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\addyot\*"; DestDir: "{#plugins}"; Components: plugins/addyot; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\camerautil\*"; DestDir: "{#plugins}"; Components: plugins/camerautil; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\colorhelp\*"; DestDir: "{#plugins}"; Components: plugins/colorhelp; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\editmenufilt\*"; DestDir: "{#plugins}"; Components: plugins/editmenufilt; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\editselanime\*"; DestDir: "{#plugins}"; Components: plugins/editselanim; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\extendrender\norm\*"; DestDir: "{#plugins}"; Components: plugins/extendrender; Flags: ignoreversion recursesubdirs createallsubdirs
  Source: "{#SrcPlugins}\extendrender\optional\*"; DestDir: "{#unityinjector}\Config"; Components: plugins/extendrender/config; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\halfdress\*"; DestDir: "{#plugins}"; Components: plugins/halfdress; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\MM\*"; DestDir: "{#plugins}"; Components: plugins/MM; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\NormExcite\*"; DestDir: "{#plugins}"; Components: plugins/normexcite; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\partsedit\*"; DestDir: "{#plugins}"; Components: plugins/partsedit; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\pluginext\*"; DestDir: "{#plugins}"; Components: plugins/pluginext; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\pngplace\*"; DestDir: "{#plugins}"; Components: plugins/pngplace; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\propitem\*"; DestDir: "{#plugins}"; Components: plugins/propitem; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\scenecap\Norm\*"; DestDir: "{#plugins}"; Components: plugins/scenecap; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\shaderchange\*"; DestDir: "{#plugins}"; Components: plugins/shaderchange; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\shapeanim\*"; DestDir: "{#plugins}"; Components: plugins/shapeanimator; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\toukascreen\*"; DestDir: "{#plugins}"; Components: plugins/toukascreen; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\voicenormalizer\UnityInjector\*"; DestDir: "{#unityinjector}"; Components: plugins/voicenorm; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\voicenormalizer\Loader\*"; DestDir: "{#loader}"; Components: plugins/voicenorm; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\xtms\UnityInjector\*"; DestDir: "{#unityinjector}"; Components: plugins/xtms; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\xtms\Loader\*"; DestDir: "{#loader}"; Components: plugins/xtms; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\yotutil\*"; DestDir: "{#plugins}"; Components: plugins/yotutil; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\cameracon\*"; DestDir: "{#plugins}"; Components: plugins/cameracon; Flags: ignoreversion recursesubdirs createallsubdirs

Source: "{#SrcPlugins}\skillcomshort\*"; DestDir: "{#plugins}"; Components: plugins/skillcomshort; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\editundo\*"; DestDir: "{#plugins}"; Components: plugins/editundo; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\conwindow\*"; DestDir: "{#plugins}"; Components: plugins/conwindow; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\personaledit\*"; DestDir: "{#plugins}"; Components: plugins/personaledit; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\nyou\*"; DestDir: "{#plugins}"; Components: plugins/nyou; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\MaidTalk\*"; DestDir: "{#UnityInjector}"; Components: plugins/MaidTalk; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\LimitFPS\*"; DestDir: "{#UnityInjector}"; Components: plugins/LimitFPS; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\lookmaid\*"; DestDir: "{#plugins}"; Components: plugins/lookmaid; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\lookmaster\*"; DestDir: "{#plugins}"; Components: plugins/lookmaster; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\dancecamadjust\*"; DestDir: "{#plugins}"; Components: plugins/dancecamadjust; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\seieki\*"; DestDir: "{#plugins}"; Components: plugins/seieki; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\facecon\*"; DestDir: "{#plugins}"; Components: plugins/facecon; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\slimeshade\*"; DestDir: "{#plugins}"; Components: plugins/slimeshade; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#srcPlugins}\YAT\Core\*"; DestDir: "{app}"; Components: Patchers/YAT; Flags: ignoreversion recursesubdirs createallsubdirs
	Source: "{#srcPlugins}\YAT\ExtraTranslations\*"; DestDir: "{#unityinjector}"; Components: misc/extrans; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\YotBackFix\*"; DestDir: "{#UnityInjector}"; Components: plugins/YOTBackFix; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\YotAtmo\*"; DestDir: "{#UnityInjector}"; Components: plugins/YOTAtmo; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcPlugins}\vibemaid\UnityInjector\*"; DestDir: "{#UnityInjector}"; Components: plugins/vibemaid; Flags: ignoreversion recursesubdirs createallsubdirs
  Source: "{#SrcPlugins}\vibemaid\GameData\*"; DestDir: "{#gamedata}\[CMI]VYM Files"; Components: plugins/vibemaid; Flags: ignoreversion recursesubdirs createallsubdirs
  Source: "{#SrcPlugins}\vibemaid\LactationAddon\*"; DestDir: "{#gamedata}\[CMI]VYM Files"; Components: plugins/vibemaid/milk; Flags: ignoreversion recursesubdirs createallsubdirs

Source: "{#SrcPlugins}\KissMaid\*"; DestDir: "{#Unityinjector}"; Components: plugins/KissMaid; Flags: ignoreversion recursesubdirs createallsubdirs

;Emo Ears
Source: "{#SrcPlugins}\emoears\norm\CM3D2.EmotionalEars.Plugin.dll"; DestDir: "{#unityinjector}"; Components: plugins/emoears; Flags: ignoreversion
Source: "{#SrcPlugins}\emoears\norm\Mod\*"; DestDir: "{#gamedata}\[CMI]EmotionalEars"; Components: plugins/emoears/mod; Flags: ignoreversion recursesubdirs createallsubdirs
;Aho Files!
Source: "{#SrcPlugins}\emoears\aho\Mod\*"; DestDir: "{#gamedata}\[CMI]EmotionalEars"; Components: plugins/emoears/aho; Flags: ignoreversion recursesubdirs createallsubdirs

;Misc Files

Source: "{#SrcMisc}\MMPoses\*"; DestDir: "{#gamedata}"; Components: Plugins/mm/mmposes; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcMisc}\ExtraPNGs\*"; DestDir: "{#unityinjector}\config"; Components: plugins/pngplace/expng; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcMisc}\SybArc\*"; DestDir: "{app}"; Components: misc/sybarc; Flags: recursesubdirs

Source: "{#SrcMisc}\TextureUncensors\FemaleSkinUncensor\*"; DestDir: "{#gamedata}\[CMI]Uncensors\FemaleSkinUncensor"; Components: misc/uncensor; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcMisc}\TextureUncensors\MaleUncensor\*"; DestDir: "{#gamedata}\[CMI]Uncensors\MaleUncensor"; Components: misc/uncensormale; Flags: ignoreversion recursesubdirs createallsubdirs


Source: "{#SrcMisc}\TextureUncensors\body_analkupa\*"; DestDir: "{#gamedata}\[CMI]Uncensors\body_analkupa"; Components: misc/body/analkupa; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SrcMisc}\TextureUncensors\lomob\*"; DestDir: "{#gamedata}\[CMI]Uncensors\LoMobBody"; Components: misc/body/LoMobBody; Flags: ignoreversion recursesubdirs createallsubdirs

; NOTE: Don't use "Flags: ignoreversion" on any shared system files
Source: "{#srcDocumentation}\LMMT_Readme.pdf"; DestDir: "{#docs}"; Flags: isreadme
Source: "{#srcDocumentation}\MM_Readme.txt"; DestDir: "{#docs}"; Components:Plugins/MM; Flags: isreadme
[/Files]