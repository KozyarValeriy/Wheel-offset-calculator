unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ScrollBox, math, FMX.StdCtrls, FMX.ExtCtrls, FMX.ListBox, FMX.Edit,
  FMX.Controls.Presentation, FMX.Objects;

type
  TForm1 = class(TForm)
    main_layout: TLayout;
    VertScrollBox1: TVertScrollBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    wheel_layout: TLayout;
    ComboBox1: TComboBox;
    properties_1: TLayout;
    properties_2: TLayout;
    ComboBox2: TComboBox;
    Edit2: TEdit;
    pictures_wheel: TLayout;
    pos_image: TImage;
    CornerButton1: TCornerButton;
    hub_layout: TLayout;
    properties_hub_1: TLayout;
    properties_hub_2: TLayout;
    Edit3: TEdit;
    ComboBox3: TComboBox;
    Edit4: TEdit;
    ComboBox4: TComboBox;
    zero_image: TImage;
    neg_image: TImage;
    CheckBox1: TCheckBox;
    Rectangle1: TRectangle;
    properties_hub_3: TLayout;
    Label5: TLabel;
    Edit5: TEdit;
    ComboBox5: TComboBox;
    Layout1: TLayout;
    pictures_layout_hub: TLayout;
    zero_hub: TImage;
    pos_hub: TImage;
    neg_hub: TImage;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    layout_with_property_hub: TLayout;
    answer_layout: TLayout;
    ComboBox6: TComboBox;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    Rectangle6: TRectangle;
    procedure FormCreate(Sender: TObject);
    procedure Edit1ChangeTracking(Sender: TObject);
    procedure Edit2ChangeTracking(Sender: TObject);
    procedure CornerButton1Click(Sender: TObject);
    procedure Edit3ChangeTracking(Sender: TObject);
    procedure Edit4ChangeTracking(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure Edit5ChangeTracking(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Label1Click(Sender: TObject);

  private
    { Private declarations }
    procedure calculate;
  public
    { Public declarations }
  end;
var
  Form1: TForm1;
  Flags: TReplaceFlags;
  counter: integer;
  procedure edit_change(Edit: TEdit);
  procedure combobox_choice(ComboBox: TComboBox; var unit_par: real);

implementation

{$R *.fmx}
{$R *.XLgXhdpiTb.fmx ANDROID}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiTb.fmx ANDROID}
{$R *.Meizu.fmx ANDROID}

procedure TForm1.CheckBox1Change(Sender: TObject);
    begin
        if CheckBox1.IsChecked then
            begin
                properties_hub_1.Visible := False;
                properties_hub_2.Visible := False;
                properties_hub_3.Visible := True;
                layout_with_property_hub.Height := 80;
                Rectangle1.Visible := False;
            end
        else
            begin
                properties_hub_1.Visible := True;
                properties_hub_2.Visible := True;
                properties_hub_3.Visible := False;
                layout_with_property_hub.Height := 120;
                Rectangle1.Visible := True;
            end;
        hub_layout.Height := layout_with_property_hub.Height +
                 answer_layout.Height + Layout1.Height;
        main_layout.Height := hub_layout.Height + wheel_layout.Height;
        calculate;
    end;

procedure TForm1.ComboBox1Change(Sender: TObject);
    begin
        calculate;
    end;

procedure TForm1.CornerButton1Click(Sender: TObject);
    begin
        pictures_wheel.Visible := not pictures_wheel.Visible;
        if pictures_wheel.Visible then
            wheel_layout.Height := 505
        else
            wheel_layout.Height := 155;
        main_layout.Height := wheel_layout.Height + hub_layout.Height;
    end;

procedure TForm1.Edit1ChangeTracking(Sender: TObject);
    begin
        edit_change(Edit1);
        calculate;
    end;

procedure TForm1.Edit2ChangeTracking(Sender: TObject);
  var number: real;
    begin
        try
            if length(Edit2.Text) > 7 then
                 Edit2.Text := copy(Edit2.Text, 0, length(Edit2.Text) - 1);
            if length(Edit2.Text) = 0 then
                number := 0
            else if ((length(Edit2.Text) = 1) and (((Edit2.text = '-') or
                                               (Edit2.text = '+')))) then
                number := 0
            else
                number := strtofloat(StringReplace(Edit2.text, '.', ',', Flags));
        except
            Edit2.Text := copy(Edit2.Text, 0, length(Edit2.Text) - 1);
            Edit2ChangeTracking(Self);
        end;
        if number = 0 then
            begin
                zero_image.Visible := True;
                pos_image.Visible := False;
                neg_image.Visible := False;
            end
        else if number > 0 then
             begin
                zero_image.Visible := False;
                pos_image.Visible := True;
                neg_image.Visible := False;
            end
        else
             begin
                zero_image.Visible := False;
                pos_image.Visible := False;
                neg_image.Visible := True;
            end;
        calculate;
    end;

procedure TForm1.Edit3ChangeTracking(Sender: TObject);
    begin
        edit_change(Edit3);
        calculate;
    end;

procedure TForm1.Edit4ChangeTracking(Sender: TObject);
    begin
        edit_change(Edit4);
        calculate;
    end;

procedure TForm1.Edit5ChangeTracking(Sender: TObject);
    begin
        edit_change(Edit5);
        calculate;
    end;

procedure TForm1.FormCreate(Sender: TObject);
  var i, j: integer; com_box: TComboBox;
    begin
        for i:=0 to ComponentCount - 1 do
                if Components[i] is TComboBox then
                    begin
                        com_box := Components[i] as TComboBox;
                        for j := 0 to com_box.Items.Count - 1 do
                            begin
                                com_box.ListBox.ListItems[j].TextSettings.Font.Size :=
                                        Edit1.TextSettings.Font.Size;
                                com_box.ListBox.ListItems[j].TextSettings.FontColor :=
                                        TAlphaColorRec.White;
                                com_box.ListBox.ListItems[j].StyledSettings :=
                                        com_box.ListBox.ListItems[j].StyledSettings
                                        - [TStyledSetting.ssFontColor];
                                com_box.ListBox.ListItems[j].StyledSettings :=
                                        com_box.ListBox.ListItems[j].StyledSettings
                                        - [TStyledSetting.ssSize];
                            end;
                    end;
        Label1.Width := max(hub_layout.Width / 5, 95);
        Label2.Width := max(hub_layout.Width / 5, 95);
        Label3.Width := max(hub_layout.Width / 4, 120);
        Label4.Width := max(hub_layout.Width / 4, 120);
        Label5.Width := max(hub_layout.Width / 4, 120);
        //Label8.Text := floattostr(Label4.Width) + ' ' + floattostr(hub_layout.Width);
        counter := 0;
    end;

procedure TForm1.Label1Click(Sender: TObject);
    begin
        if counter = 0 then
            begin
                showmessage('Для более точного результата лучше вводить ширину по покрышке');
                counter := 1;
            end;
    end;

procedure edit_change(Edit: TEdit);
var number: real;
    begin
         try
            if length(Edit.Text) > 7 then
                 Edit.Text := copy(Edit.Text, 0, length(Edit.Text) - 1);
            number := strtofloat(StringReplace(Edit.text, '.', ',', Flags))
         except
            Edit.Text := copy(Edit.Text, 0, length(Edit.Text) - 1);
         end;
    end;

procedure TForm1.calculate;
var unit_T, unit_ET, unit_hub, unit_body, unit_h_to_b, T, ET, hub, body, h_to_b,
    offset, unit_offset: real;
    offset_str :string;
    begin
        // Sistem of calculation for disk width
        combobox_choice(ComboBox1, unit_T);
        // Sistem of calculation for parametr ET
        combobox_choice(ComboBox2, unit_ET);
        // Sistem of calculation for body width
        combobox_choice(ComboBox3, unit_hub);
        // Sistem of calculation for hub to hub width
        combobox_choice(ComboBox4, unit_body);
        // Sistem of calculation for hub to body width
        combobox_choice(ComboBox5, unit_h_to_b);
        // Sistem of calculation for offset
        combobox_choice(ComboBox6, unit_offset);

        try
            if CheckBox1.IsChecked then
                h_to_b := strtofloat(StringReplace(Edit5.text, '.', ',', Flags)) *
                              unit_h_to_b
            else
                begin
                    hub := strtofloat(StringReplace(Edit4.text, '.', ',', Flags)) *
                              unit_hub;
                    body := strtofloat(StringReplace(Edit3.text, '.', ',', Flags)) *
                              unit_body;
                    h_to_b := (body - hub) / 2;
                end;

            T := strtofloat(StringReplace(Edit1.text, '.', ',', Flags)) * unit_T;
            ET := strtofloat(StringReplace(Edit2.text, '.', ',', Flags)) * unit_ET;

            offset := (T/2 - ET) - h_to_b;
            offset := offset / unit_offset;
            offset_str := floattostr(roundto(offset, -2));
        except
            offset_str := 'None';
            offset := 0;
        end;
        Label8.Text := 'Offset = ' + offset_str;
        if roundto(offset, -2) > 0 then
            begin
                zero_hub.Visible := False;
                pos_hub.Visible := True;
                neg_hub.Visible := False;
            end
        else if roundto(offset, -2) < 0 then
            begin
                zero_hub.Visible := False;
                pos_hub.Visible := False;
                neg_hub.Visible := True;
            end
        else
            begin
                zero_hub.Visible := True;
                pos_hub.Visible := False;
                neg_hub.Visible := False;
            end;
    end;

procedure combobox_choice(ComboBox: TComboBox; var unit_par: real);
    begin
        if ComboBox.ItemIndex = 0 then
            unit_par := 25.4
        else if ComboBox.ItemIndex = 1 then
            unit_par := 1
        else if ComboBox.ItemIndex = 2 then
            unit_par := 10
        else if ComboBox.ItemIndex = 3 then
            unit_par := 100
        else
            unit_par := 1000;
    end;

end.
