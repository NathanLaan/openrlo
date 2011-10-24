using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace OpenRLO.Web.Data
{
  public class Index<T> where T : IndexItem, IComparable<T>, new()
  {

    private List<T> indexList;
    public List<T> IndexList
    {
      get
      {
        return indexList;
      }
    }

    public string FileName { get; set; }

    public Index() : this("")
    {
    }
    public Index(string fileName)
    {
      this.FileName = fileName;
      this.indexList = new List<T>();
      this.Load();
    }

    public void Add(T item)
    {
      if (!this.Exists(item.Key))
      {
        this.indexList.Add(item);
        this.indexList.Sort();
      }
    }


    public void Delete(string key)
    {
      T item = this.Get(key);
      if (item != null)
      {
        this.indexList.Remove(item);
      }
    }

    public void Save()
    {
      StringBuilder stringBuilder = new StringBuilder();
      foreach (T t in this.indexList)
      {
        stringBuilder.Append(t.Save());
      }
      using (StreamWriter streamWriter = new StreamWriter(this.FileName))
      {
        streamWriter.Write(stringBuilder.ToString());
      }
    }

    public void Load()
    {
      this.indexList.Clear();
      if (File.Exists(this.FileName))
      {
        using (StreamReader sr = new StreamReader(this.FileName))
        {
          string fullFileContents = sr.ReadToEnd();
          if (fullFileContents != null && fullFileContents != string.Empty)
          {
            string[] fileLines = fullFileContents.Split(Environment.NewLine.ToCharArray());
            foreach (string line in fileLines)
            {
              if (line != null && line != string.Empty)
              {
                T t = new T();
                t.Load(line);
                this.indexList.Add(t);
              }
            }
            this.indexList.Sort();
          }
        }
      }
      else
      {
        //TODO: nothing???
      }
    }


    public T Get(string key)
    {
      foreach (T t in this.indexList)
      {
        if (key.Equals(t.Key))
        {
          return t;
        }
      }
      return default(T);
    }


    public bool Exists(string val)
    {
      foreach (T t in this.indexList)
      {
        if (val.Equals(t.Val))
        {
          return true;
        }
      }
      return false;
    }


    /*
    private void ReOrder()
    {
      // insertion sort
      int i;
      int x = this.siteLinkList.Count;
      this.siteLinkList.Sort();

      // re-ordering
      if (this.siteLinkList.Count > 0)
      {
        this.siteLinkList[0].Order = 0;
        for (i = 1; i < x; i++)
        {
          int diff = this.siteLinkList[i].Order - this.siteLinkList[i - 1].Order;
          if (diff > 1)
          {
            this.siteLinkList[i].Order = this.siteLinkList[i - 1].Order + 1;
          }
        }
      }
    }

    public bool MoveUp(string title)
    {
      int x = this.siteLinkList.Count;
      if (x > 1)
      {
        for (int i = 1; i < x; i++)
        {
          if (this.siteLinkList[i].Title.Equals(title))
          {
            int o = this.siteLinkList[i].Order;
            this.siteLinkList[i].Order = this.siteLinkList[i - 1].Order;
            this.siteLinkList[i - 1].Order = o;
          }
        }
      }
      this.siteLinkList.Sort();
      this.Save();
      return true;
    }

    public bool MoveDown(string title)
    {
      int x = this.siteLinkList.Count;
      if (x > 1)
      {
        for (int i = x - 1; i >= 0; i--)
        {
          if (this.siteLinkList[i].Title.Equals(title))
          {
            int o = this.siteLinkList[i].Order;
            this.siteLinkList[i].Order = this.siteLinkList[i + 1].Order;
            this.siteLinkList[i + 1].Order = o;
          }
        }
      }
      this.siteLinkList.Sort();
      this.Save();
      return true;
    }
    */

  }
}