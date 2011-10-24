//using System;
//using System.Collections.Generic;
//using System.Text;
//using System.IO;

//namespace OpenRLO.Web.Data
//{
//  public class CategoryIndex
//  {

//    private string filename = "/App_Data/CategoryIndexNew.txt";
//    public string Filename
//    {
//      get { return filename; }
//      set { filename = value; }
//    }

//    private List<Category> list;
//    public List<Category> List
//    {
//      get { return list; }
//      set { list = value; }
//    }

//    public CategoryIndex()
//    {
//      this.list = new List<Category>();
//    }

//    public int Add(Category category)
//    {
//      int order = 0;
//      foreach (Category c in this.list)
//      {
//        order = Math.Max(order, c.Order + 1);
//      }
//      category.Order = order;
//      this.list.Add(category);
//      this.Save();
//      return order;
//    }

//    public string GetCategoryTitleForUrl(string url)
//    {
//      if (url == "(None)")
//      {
//        return url;
//      }
//      foreach (Category c in this.list)
//      {
//        if (url.Equals(c.Url))
//        {
//          return c.Title;
//        }
//      }
//      return url;
//    }

//    public Category GetCategoryForUrl(string url)
//    {
//      foreach (Category c in this.list)
//      {
//        if (url.Equals(c.Url))
//        {
//          return c;
//        }
//      }
//      return null;
//    }

//    public bool Delete(string title)
//    {
//      foreach (Category c in this.list)
//      {
//        if (title.Equals(c.Title))
//        {
//          this.list.Remove(c);
//          this.ReOrder();
//          this.Save();
//          return true;
//        }
//      }
//      return false;
//    }

//    private void ReOrder()
//    {
//      // insertion sort
//      int i;
//      int x = this.list.Count;
//      this.list.Sort();

//      // re-ordering
//      if (this.list.Count > 0)
//      {
//        this.list[0].Order = 0;
//        for (i = 1; i < x; i++)
//        {
//          int diff = this.list[i].Order - this.list[i - 1].Order;
//          if (diff > 1)
//          {
//            this.list[i].Order = this.list[i - 1].Order + 1;
//          }
//        }
//      }
//    }

//    public bool MoveUp(string title)
//    {
//      int x = this.list.Count;
//      if (x > 1)
//      {
//        for (int i = 1; i < x; i++)
//        {
//          if (this.list[i].Title.Equals(title))
//          {
//            int o = this.list[i].Order;
//            this.list[i].Order = this.list[i - 1].Order;
//            this.list[i - 1].Order = o;
//          }
//        }
//      }
//      this.list.Sort();
//      this.Save();
//      return true;
//    }

//    public bool MoveDown(string title)
//    {
//      int x = this.list.Count;
//      if (x > 1)
//      {
//        for (int i = x - 1; i >= 0; i--)
//        {
//          if (this.list[i].Title.Equals(title))
//          {
//            int o = this.list[i].Order;
//            this.list[i].Order = this.list[i + 1].Order;
//            this.list[i + 1].Order = o;
//          }
//        }
//      }
//      this.list.Sort();
//      this.Save();
//      return true;
//    }

//    public bool Exists(string title)
//    {
//      if (this.list.Count > 0)
//      {
//        foreach (Category c in this.list)
//        {
//          if (title.Equals(c.Title))
//          {
//            return true;
//          }
//        }
//      }
//      return false;
//    }

//    public void Load()
//    {
//      this.list.Clear();
//      //TODO: more error handling
//      if (File.Exists(this.Filename))
//      {
//        using (StreamReader sr = new StreamReader(this.Filename))
//        {
//          string fullFileContents = sr.ReadToEnd();
//          if (fullFileContents != null && fullFileContents != string.Empty)
//          {
//            string[] fileLines = fullFileContents.Split(Environment.NewLine.ToCharArray());
//            foreach (string line in fileLines)
//            {
//              if (line != null && line != string.Empty)
//              {
//                string[] indexEntries = line.Split(Constants.IndexEntryDelimiter);
//                if (indexEntries.Length > 2)
//                {
//                  Category category = new Category();
//                  category.Order = int.Parse(indexEntries[0]);
//                  category.Url = indexEntries[1];
//                  category.Title = indexEntries[2];
//                  this.list.Add(category);
//                }
//              }
//            }
//            this.list.Sort();
//          }
//        }
//      }
//      else
//      {
//        //TODO: nothing???
//      }
//    }

//    public void Save()
//    {
//      StringBuilder sb = new StringBuilder();
//      foreach (Category category in this.list)
//      {
//        sb.Append(category.Order);
//        sb.Append(Constants.IndexEntryDelimiter);
//        sb.Append(category.Url);
//        sb.Append(Constants.IndexEntryDelimiter);
//        sb.Append(category.Title);
//        sb.Append(Environment.NewLine);
//      }
//      using (StreamWriter streamWriter = new StreamWriter(this.Filename))
//      {
//        streamWriter.Write(sb.ToString());
//      }
//    }

//  }
//}
