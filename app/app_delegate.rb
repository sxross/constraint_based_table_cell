class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = TableViewController.new
    @window.makeKeyAndVisible
  end
end

class TableViewController < UITableViewController
  def viewDidLoad
    self.view.registerClass(CustomCell, 
      forCellReuseIdentifier:'cell id')
  end
  
  def tableView(tableView, numberOfSectionsInTableView:section)
    1
  end
  
  def tableView(tableView, numberOfRowsInSection:section)
    3
  end
  
  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier('cell id')
    
    cell.title_label = "title #{indexPath.row}"
    cell.details_label = "details #{indexPath.row}"
    cell.attendees_label = "attendees #{indexPath.row}"
    
    cell
  end
end

class CustomCell < UITableViewCell
  attr_accessor :title_label, :details_label, :attendees_label
  # include Teacup::Layout
  stylesheet :main

  def initWithStyle(style, reuseIdentifier:cell_identifier)
    super
    create_cell_subviews
    self
  end

  def create_cell_subviews
    self.accessoryType = UITableViewCellAccessoryDetailDisclosureButton

    layout(self.contentView, :root) do
      subview UIView, :padding do
        self.title_label = subview UILabel, :cell_title_label
        self.details_label = subview UILabel, :cell_details_label
        self.attendees_label = subview UILabel, :cell_attendees_label
      end
    end

    self
  end
end

Teacup::Stylesheet.new :main do
  style :root,
    backgroundColor: UIColor.colorWithRed(247.0 / 256.0, green:221.0 / 256.0, blue:186.0 / 256.0, alpha:1)
  
  style :padding,
   backgroundColor: UIColor.greenColor,
   constraints: [
     constrain(:width).equals(:superview, :width).times(0.96),
     constrain(:height).equals(:superview, :height).times(0.96),
     constrain(:center_x).equals(:superview, :center_x),
     constrain(:center_y).equals(:superview, :center_y)
   ]

  style :cell_title_label,
    font: UIFont.boldSystemFontOfSize(17),
    constraints: [
      constrain_height(20),
      constrain(:top).equals(:superview, :top),
      constrain(:width).equals(:superview, :width),
      constrain(:center_x).equals(:superview, :center_x)
    ]

  style :cell_details_label,
      font: UIFont.systemFontOfSize(14),
      color: UIColor.grayColor,
      constraints: [
        constrain_height(17),
        constrain_below(:cell_title_label, 5),
        constrain(:width).equals(:superview, :width),
        constrain(:center_x).equals(:superview, :center_x)
      ]

  style :cell_attendees_label,
      font: UIFont.systemFontOfSize(14),
      color: UIColor.grayColor,
      constraints: [
        constrain_height(17),
        constrain_below(:cell_details_label, 5),
        constrain(:width).equals(:superview, :width),
        constrain(:center_x).equals(:superview, :center_x)
      ]
end
