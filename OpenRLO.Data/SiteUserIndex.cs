﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Text;

namespace OpenRLO.Data
{
  public sealed class SiteUserIndex
  {

    private string filename;
    public string Filename
    {
      get { return filename; }
      set { filename = value; }
    }

    private List<SiteUser> list;
    public List<SiteUser> SiteUserList
    {
      get { return list; }
      set { list = value; }
    }

    public SiteUserIndex(string filename)
    {
      this.list = new List<SiteUser>();
      this.filename = filename;
    }

    public string GetDisplayName(string username)
    {
      string usernameLower = username.ToLower();
      foreach (SiteUser siteUser in this.list)
      {
        if (usernameLower.Equals(siteUser.Username.ToLower()))
        {
          return siteUser.Showname;
        }
      }
      return "";
    }

    public bool ValidateUser(string username, string password)
    {
      string usernameLower = username.ToLower();
      foreach (SiteUser siteUser in this.list)
      {
        if (usernameLower.Equals(siteUser.Username.ToLower()))
        {
          string hashcode = SiteUser.CreatePassword(password, siteUser.Saltcode);
          if (siteUser.Password.Equals(hashcode))
          {
            return true;
          }
        }
      }
      return false;
    }
    
    public void Load()
    {
      this.list.Clear();
      if (File.Exists(this.Filename))
      {
        using (StreamReader sr = new StreamReader(Filename))
        {
          string fullFileContents = sr.ReadToEnd();
          if (fullFileContents != null && fullFileContents != string.Empty)
          {
            string[] fileLines = fullFileContents.Split(Environment.NewLine.ToCharArray());
            foreach (string line in fileLines)
            {
              if (line != null && line != string.Empty)
              {
                string[] indexEntries = line.Split(Constants.IndexEntryDelimiter);
                if (indexEntries.Length > 2)
                {
                  SiteUser siteUser = new SiteUser();
                  siteUser.Username = indexEntries[0];
                  siteUser.Showname = indexEntries[1];
                  siteUser.Saltcode = indexEntries[2];
                  siteUser.Password = indexEntries[3];
                  siteUser.Timezone = indexEntries[4];
                  siteUser.Email = indexEntries[5];
                  this.list.Add(siteUser);
                }
              }
            }
          }
        }
      }

      if (this.list.Count == 0)
      {
        SiteUser siteUser = new SiteUser();
        siteUser.Email = "";
        siteUser.Timezone = "GMT";
        siteUser.Username = "admin";
        siteUser.Showname = "Admin";
        siteUser.Passcode = siteUser.Username;
        this.list.Add(siteUser);
      }
    }

    public void Save()
    {
      StringBuilder sb = new StringBuilder();
      foreach (SiteUser siteUser in this.list)
      {
        sb.Append(siteUser.Username);
        sb.Append(Constants.IndexEntryDelimiter);
        sb.Append(siteUser.Showname);
        sb.Append(Constants.IndexEntryDelimiter);
        sb.Append(siteUser.Saltcode);
        sb.Append(Constants.IndexEntryDelimiter);
        sb.Append(siteUser.Password);
        sb.Append(Constants.IndexEntryDelimiter);
        sb.Append(siteUser.Timezone);
        sb.Append(Constants.IndexEntryDelimiter);
        sb.Append(siteUser.Email);
        sb.Append(Constants.IndexEntryDelimiter);
        sb.Append(Environment.NewLine);
      }
      //sb.Append(" ");
      using (StreamWriter streamWriter = new StreamWriter(this.Filename))
      {
        streamWriter.Write(sb.ToString());
      }
    }

    public bool Delete(string username)
    {
      foreach (SiteUser siteUser in this.list)
      {
        if (siteUser.Username.Equals(username))
        {
          this.list.Remove(siteUser);
          this.Save();
          return true;
        }
      }
      return false;
    }

  }
}