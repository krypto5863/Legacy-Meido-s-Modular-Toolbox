using System;
using System.Collections.Generic;
using System.IO;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace LMMTHelper
{
	public class LMMTHelper
	{
		[DllExport("LMMTHelper", CallingConvention = CallingConvention.StdCall)]
		public static bool VersionCheck([MarshalAs(UnmanagedType.BStr)] string path, int ver)
		{
			//path = @"D:\KISS\COM3D2";
			//System.Windows.Forms.MessageBox.Show("Starting function with params"+@path+" "+ver, "Caption Here!", MessageBoxButtons.OK);
			string file = @"CM3D2x64_Data\Managed\Assembly-CSharp.dll";
			if (File.Exists(@path + @"\update.lst") && File.Exists(@path + @"\CM3D2x64.exe"))
			{
				string[] lines = File.ReadAllLines(@path + @"\update.lst");
				//System.Windows.Forms.MessageBox.Show("Trying to read " + @path + @"\update.lst", "Caption Here!", MessageBoxButtons.OK);
				// System.Windows.Forms.MessageBox.Show("This is the first string: " + lines[0], "Caption Here!", MessageBoxButtons.OK);
				foreach (string line in lines)
				{
					if (line.Contains(file))
					{
						string gver = line;
						//System.Windows.Forms.MessageBox.Show("We found the line!", "Caption Here!", MessageBoxButtons.OK);
						try
						{

							String res = gver.Remove(0, 42);
							//System.Windows.Forms.MessageBox.Show(res, "Caption Here!", MessageBoxButtons.OK);
							int ngver = Int32.Parse(res);


							if (ver <= ngver)
							{
								System.Windows.Forms.MessageBox.Show("Your game version was successfully checked and you are on an acceptable version!\n\nFound Version: " + ngver, "Version Check Success!", MessageBoxButtons.OK, MessageBoxIcon.Information);
								return true;
							}
							else
							{
								System.Windows.Forms.MessageBox.Show("Your game is outdated! Update your game!\n\nYour game version was successfully checked and you are not on an acceptable version!\n\nExpected Version: " + ver + " or higher\nFound Version: " + ngver, "Game is outdated! Update!", MessageBoxButtons.OK, MessageBoxIcon.Error);
								return false;
							}
						}
						catch (FormatException)
						{
							System.Windows.Forms.MessageBox.Show("Whoops, an exception was thrown..", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
						}

					}
				}
			}

			if (File.Exists(@path + @"\COM3D2x64.exe"))
			{
				System.Windows.Forms.MessageBox.Show("This is COM3D2! LMMT is not made for COM3D2, use CMI instead!", "Wrong Game!", MessageBoxButtons.OK, MessageBoxIcon.Error);
				return false;
			}

			if (File.Exists(@path + @"\update.lst") && File.Exists(@path + @"\CM3D2x64.exe"))
			{
				System.Windows.Forms.MessageBox.Show("While we managed to find the Update.lst file, the assembly version could not be found! Please update immediately!", "Version Check Failed!", MessageBoxButtons.OK, MessageBoxIcon.Error);
				return false;
			}

			var result = System.Windows.Forms.MessageBox.Show("This does not appear to be a CM3d2 Directory! We can still continue the installation but you may be installing to the wrong directory.\n\nInstalling to an empty directory will render the SymLink creation for BepinEX useless. Do we continue anyways?", "Wrong Directory!", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
			// If the no button was pressed ...
			if (result == DialogResult.No)
			{
				return false;
			}
			if (result == DialogResult.Yes)
			{
				return true;
			}
			return false;
		}

		//[DllExport("LMMTHelperC", CallingConvention = CallingConvention.StdCall)]
		//public static bool ConfigReplace([MarshalAs(UnmanagedType.BStr)] string path)
		//{
		//    if (File.Exists(@path + @"\Sybaris\Unityinjector\Config"))
		//    {
		//        try
		//        {
		//            CopyDirectory(){ }
		//        }
		//        catch (IOException)
		//        {

		//        }

		//    }
		//}

		[DllExport("LMMTHelperM", CallingConvention = CallingConvention.StdCall)]
		public static bool MoveOld([MarshalAs(UnmanagedType.BStr)] string path)
		{
			List<string> corefiles = new List<string>();
			corefiles.Add(@"\Sybaris\Loader");
			corefiles.Add(@"\Sybaris\Plugins");
			corefiles.Add(@"\Sybaris\Poses");
			corefiles.Add(@"\Sybaris\Preset");
			corefiles.Add(@"\Sybaris\IgnoreMenus.txt");
			corefiles.Add(@"\opengl32.dll");

			corefiles.Add(@"\BepinEX");
			corefiles.Add(@"\scripts");
			corefiles.Add(@"\doorstop_config.ini");
			corefiles.Add(@"\winhttp.dll");
			corefiles.Add(@"\version.dll");

			corefiles.Add(@"\IMGUITranslationLoader");
			corefiles.Add(@"\EngSybarisArcEditor.exe");
			corefiles.Add(@"\LMMT Documentation");

			foreach (string file in corefiles)
			{
#if DEBUG
                System.Windows.Forms.MessageBox.Show("We are trying to move: " + path + file, "DEBUG", MessageBoxButtons.OK, MessageBoxIcon.Information);
#endif
				if (Directory.Exists(path + file) || File.Exists(path + file))
				{
#if DEBUG
                    System.Windows.Forms.MessageBox.Show("Directory Found!", "DEBUG", MessageBoxButtons.OK, MessageBoxIcon.Information);
#endif
#if DEBUG
                    System.Windows.Forms.MessageBox.Show("Attempting Directory Move to " + path + @"\OldInstall" + file, "DEBUG", MessageBoxButtons.OK, MessageBoxIcon.Information);
#endif
					if (!CMD.Move(path + file, path + @"\OldInstall" + file))
					{
						return false;
					}
				}
			}
			return true;
		}

		[DllExport("LMMTHelperMO", CallingConvention = CallingConvention.StdCall)]
		public static bool MoveOldMod([MarshalAs(UnmanagedType.BStr)] string path)
		{
			List<string> corefiles = new List<string>();
			corefiles.Add(@"\MultipleMaidsPose");
			corefiles.Add(@"\[CMI]EmotionalEars");
			corefiles.Add(@"\[CMI]VYM Files");
			corefiles.Add(@"\[CMI]Uncensors");
			corefiles.Add(@"\Samples");

			foreach (string file in corefiles)
			{
#if DEBUG
                System.Windows.Forms.MessageBox.Show("We are trying to move: " + file, "DEBUG", MessageBoxButtons.OK, MessageBoxIcon.Information);
#endif

				if (Directory.Exists(path + @"\Sybaris\GameData" + file) || File.Exists(path + @"\Sybaris\GameData" + file))
				{
#if DEBUG
                    System.Windows.Forms.MessageBox.Show("Directory Found!", "DEBUG", MessageBoxButtons.OK, MessageBoxIcon.Information);
					System.Windows.Forms.MessageBox.Show("Trying Directory Move!", "DEBUG", MessageBoxButtons.OK, MessageBoxIcon.Information);
#endif
					if (!CMD.Move(path + @"\Sybaris\GameData" + file, path + @"\OldInstall\Sybaris\GameData" + file))
					{
						return false;
					}
				}
			}
			return true;
		}

		[DllExport("LMMTHelperOR", CallingConvention = CallingConvention.StdCall)]
		public static bool RenameOldInstall([MarshalAs(UnmanagedType.BStr)] string path)
		{
			if (Directory.Exists(path + @"\OldInstall"))
			{

				bool result = true;

				DateTime ct = File.GetCreationTime(path + @"\OldInstall");

				if (Directory.Exists(path + @"\OldInstall " + ct.ToString("MM.dd.yyyy.h.mm")))
				{
					result = CMD.Run(@"rename " + '\u0022' + path + @"\OldInstall" + '\u0022' + " " + '\u0022' + @"OldInstall " + ct.ToString("MM.dd.yyyy.h.mm.ss") + '\u0022');
				}
				else
				{
					result = CMD.Run(@"rename " + '\u0022' + path + @"\OldInstall" + '\u0022' + " " + '\u0022' + @"OldInstall " + ct.ToString("MM.dd.yyyy.h.mm") + '\u0022');
				}

				if (result == false)
				{
					System.Windows.Forms.MessageBox.Show("We encountered an error while trying to rename the OldInstall folder!", "Error while performing command!", MessageBoxButtons.OK, MessageBoxIcon.Error);
					return false;
				}

			}
			return true;
		}

		[DllExport("LMMTHelperBC", CallingConvention = CallingConvention.StdCall)]
		public static int BitCheck([MarshalAs(UnmanagedType.BStr)] string path)
		{
			int bit = 0;
			if (File.Exists(path + @"\CM3D2x64.exe"))
			{
				bit += 64;
			}
			if (File.Exists(path + @"\CM3D2x86.exe"))
			{
				bit += 86;
			}
			return bit;
		}

		[DllExport("LMMTHelperMS", CallingConvention = CallingConvention.StdCall)]
		public static bool MakeSym([MarshalAs(UnmanagedType.BStr)] string path)
		{
#if DEBUG
            System.Windows.Forms.MessageBox.Show("Starting Symlink creation", "Symlink", MessageBoxButtons.OK, MessageBoxIcon.Information);
#endif
			if (!Directory.Exists(path + @"\Mod"))
			{
				if (!CMD.Run(@"mkdir " + '\u0022' + path + @"\Mod" + '\u0022'))
				{
					System.Windows.Forms.MessageBox.Show("We encountered an error while trying to create the symlink!", "Error while performing command!", MessageBoxButtons.OK, MessageBoxIcon.Error);
					return false;
				}
			}

			if (!Directory.Exists(path + @"\Sybaris\GameData"))
			{
				if (!CMD.Run(@"mkdir " + '\u0022' + path + @"\Sybaris\GameData" + '\u0022'))
				{
					System.Windows.Forms.MessageBox.Show("We encountered an error while trying to create the symlink!", "Error while performing command!", MessageBoxButtons.OK, MessageBoxIcon.Error);
					return false;
				}
			}


			if (!File.Exists(path + @"\Mod\[CMI]GameData Link") && !Directory.Exists(path + @"\Mod\[CMI]GameData Link"))
			{
#if DEBUG
                System.Windows.Forms.MessageBox.Show("Making link", "Symlink", MessageBoxButtons.OK, MessageBoxIcon.Information);
#endif
				if (!CMD.Run(@"mklink /D " + '\u0022' + path + @"\Mod\[CMI]GameData Link" + '\u0022' + " " + '\u0022' + path + @"\Sybaris\GameData" + '\u0022'))
				{
					System.Windows.Forms.MessageBox.Show("We encountered an error while trying to create the symlink!", "Error while performing command!", MessageBoxButtons.OK, MessageBoxIcon.Error);
					return false;
				}
			}
			return true;
		}
	}
}