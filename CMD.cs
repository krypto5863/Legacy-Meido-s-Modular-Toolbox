using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LMMTHelper
{
    class CMD
    {
        public static bool Run(string command)
        {

            var res = DialogResult.OK;

            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/c " + command;
            startInfo.UseShellExecute = false;
            startInfo.Verb = "runas";
            startInfo.RedirectStandardOutput = true;
            startInfo.RedirectStandardError = true;
            startInfo.CreateNoWindow = true;
            process.StartInfo = startInfo;

            do
            {

                res = DialogResult.OK;

                process.Start();

                string line = process.StandardOutput.ReadToEnd();
                string err = process.StandardError.ReadToEnd();
#if DEBUG
            System.Windows.Forms.MessageBox.Show(startInfo.Arguments + "\n\n" + line, "DEBUG", MessageBoxButtons.OK, MessageBoxIcon.Information);
#endif

                process.WaitForExit();

                if (!err.Equals("") && err != null)
                {
                    res = System.Windows.Forms.MessageBox.Show("An error was tossed while trying to carry out a command!\n\n" + err + "\n\nClose all open windows and try again, or ignore the error and continue. Otherwise you may abort the installation.", "Error while performing command!", MessageBoxButtons.AbortRetryIgnore, MessageBoxIcon.Error);

                    if (res == DialogResult.Abort)
                    {
                        return false;
                    }
                }
            } while (res == DialogResult.Retry);
            return true;
        }

        public static bool Move(string src, string trg)
        {

            var res = DialogResult.OK;

            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/c move /y " +
                '\u0022' + src + '\u0022' +
                " " +
                '\u0022' + trg + '\u0022';

            startInfo.UseShellExecute = false;
            startInfo.Verb = "runas";
            startInfo.RedirectStandardOutput = true;
            startInfo.RedirectStandardError = true;
            startInfo.CreateNoWindow = true;
            process.StartInfo = startInfo;

            do
            {

                res = DialogResult.OK;

                process.Start();


                string err = process.StandardError.ReadToEnd();
                string line = process.StandardOutput.ReadToEnd();
                process.WaitForExit();
#if DEBUG
            System.Windows.Forms.MessageBox.Show(startInfo.Arguments + "\n\n" + line, "DEBUG", MessageBoxButtons.OK, MessageBoxIcon.Information);
#endif
                if (line.Contains("0"))
                {
                    res = System.Windows.Forms.MessageBox.Show("We failed to move the file at " + src + "\n\n" + err + "\n\nClose all open windows and try again. Otherwise, you can ignore it or abort the installation. Ignoring could cause problems with the installation!", "Error while moving!", MessageBoxButtons.AbortRetryIgnore, MessageBoxIcon.Error);
                    if (res == DialogResult.Abort)
                    {
                        return false;
                    }
                }
            } while (res == DialogResult.Retry);

            return true;
        }
    }
}
