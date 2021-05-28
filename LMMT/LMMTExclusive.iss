[Code]
Procedure GetBitString();
begin	
	if x86bit then
		bitString := 'x86';
	if x64bit then
		bitString := 'x64';
end;

procedure NoteBits(const path: String);
begin
	x86bit := true
	x64bit := true
	
	if EmptyFolder = true then
	begin
		x86bit := true;
		x64bit := true;
		exit;
	end;
	
	if FileExists(path + '\CM3D2x86.exe') = false then
		x86bit := false;
	if FileExists(path + '\CM3D2x64.exe') = false then
		x64bit := false;
		
	GetBitString();
end;

procedure FixBitComponents();
begin

	Log('Fixing bit components...')

  if x64bit = false then
  begin
		Log('Disabling x64 components.')
    Wizardform.ComponentsList.Checked[2] := false
    Wizardform.ComponentsList.Checked[3] := true
    Wizardform.ComponentsList.Checked[11] := false
      
    Wizardform.ComponentsList.ItemEnabled[2] := false
    Wizardform.ComponentsList.ItemEnabled[11] := false
      //Updates checkboxes.
    WizardForm.TypesCombo.OnChange(WizardForm.TypesCombo);
  end;
	
  if x86bit = false then
  begin
		Log('Disabling x86 components.')
    Wizardform.ComponentsList.Checked[3] := false
    Wizardform.ComponentsList.Checked[12] := false
      
    Wizardform.ComponentsList.ItemEnabled[3] := false
    Wizardform.ComponentsList.ItemEnabled[12] := false
    //Updates checkboxes.
    WizardForm.TypesCombo.OnChange(WizardForm.TypesCombo);
  end;	
end;

[/Code]

