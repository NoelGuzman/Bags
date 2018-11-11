with ada.Exceptions; use Ada.Exceptions;
with List_Package;
with Ada.Text_IO; use Ada.Text_IO;

procedure Bags is

   type ItemsType is (Plane, Car, Quit);
   currentItem : ItemsType := Car;
   package ItemsTypeIO is new Ada.Text_IO.Enumeration_IO(ItemsType);
   use ItemsTypeIO;

   type Ops is (Front, Rear, Delete, Size, Print);
   package OpsIO is new Ada.Text_IO.Enumeration_IO(Ops);
   use OpsIO;

   type Make is (Ford, GMC, Ram, Chevy, Boeing, Piper, Cessna);
   package MakeIO is new ada.Text_IO.Enumeration_IO(Make);
   use MakeIO;

  package IntIO is new Ada.Text_IO.Integer_IO(Integer);
   use IntIO;
   type Searchby is (Maker, Doors, Engine);
   package SearchIO is new ada.Text_IO.Enumeration_IO(Searchby); use SearchIO;
   Searchtype : Searchby;
   --ItemMake : Make;
   --NumDoors : Integer;
   --NumEngine : Integer;
   Knt : Integer := 1;

   type InventoryItem is record
      ItemMake : Make;
      NumDoors : Integer;
      NumEngines : Integer := 2;
   end record;

   temp, theItem: InventoryItem;
   OperationType : Ops;

   package InventoryList is new List_Package(InventoryItem); use InventoryList;

   Cars, Planes, TempListPT, currPT : List_Package_NodePT;
   Worked, Found : Boolean;

begin

   while currentItem /= Quit loop
      Put("Enter type of data (Quit to Exit Program): "); Get(currentItem); New_Line;
      If currentItem = Plane then
         Put("Enter Operation(Front,Rear,Etc.): "); Get(OperationType); New_Line;
         if OperationType = Front or OperationType = Rear then
            Put("Enter Manufacturer Name: "); Get(theItem.ItemMake); New_Line;
            Put("Enter Number of Doors: "); Get(theItem.NumDoors); New_Line;
            Put("Enter Number of Engines: "); Get(theItem.NumEngines); New_Line;

            if OperationType = Front then
               InsertFront(Planes, theItem, Worked);
               if Worked = True then
                  Put("Input Successful"); New_Line;
               else
                  Put("Input Failed"); New_Line;
                  end if;
            else
               InsertRear(Planes, theItem, Worked);
               if Worked = True then
                  Put("Input Successful"); New_Line;
               else
                  Put("Input Failed"); New_Line;
                  end if;
            end if;
         elsif OperationType = Delete then
            --Find First
            --Delete Operation
            Put("Enter what you want to search by: "); Get(Searchtype); New_Line;
            if Searchtype = Maker then
               Put("Enter Maker: "); Get(theItem.ItemMake);
            elsif Searchtype = Doors then
               Put("Enter number of doors: "); Get(theItem.NumDoors);
            else
               Put("Enter number of Engines: "); Get(theItem.NumEngines);
            end if;

            currPT := Cars;
            Found := False;
            TempListPT := findItem(Planes, temp);
            While Found = False loop
               case Searchtype is
                  when Maker =>
                     if temp.ItemMake = theItem.ItemMake then
                        Found := True;
                     end if;
                     when Doors =>
                        if temp.NumDoors = theItem.NumDoors then
                           Found := True;
                        end if;
                     when Engine =>
                        if temp.NumEngines = theItem.NumEngines then
                           Found := True;
                        end if;
               end case;
               if found = False then
                  currPT := TempListPT;
                  TempListPT := findItem(TempListPT, temp);
               end if;
            end loop;
            Delete(Planes, currPT);
            TempListPT := null;

         elsif OperationType = Print then
            --Print List
            Knt := listSize(Planes);
            TempListPT := null;
            TempListPT := findItem(Planes, temp);
            while Knt /= 0 loop
               Put("Make is "); Put(temp.ItemMake); New_Line;
               Put("Number of Doors is "); Put(temp.NumDoors); New_Line;
               Put("Number of Engines is "); Put(temp.NumEngines); New_Line(2);
               Knt := Knt -1;
               if Knt > 0 then
                  TempListPT := findItem(TempListPT, temp);
               end if;
            end loop;
         else
            Put(ListSize(Planes)); New_Line;
         end if;
      elsif currentItem = Car then-- Car List
         Put("Enter Operation(Front,Rear,Etc.): "); Get(OperationType); New_Line;
      if OperationType = Front or OperationType = Rear then
            Put("Enter Manufacturer Name: "); Get(theItem.ItemMake); New_Line;
            Put("Enter Number of Doors: "); Get(theItem.NumDoors); New_Line;

            if OperationType = Front then
               InsertFront(Cars, theItem, Worked);
               if Worked = True then
                  Put("Input Successful"); New_Line;
               else
                  Put("Input Failed"); New_Line;
                  end if;
            else
               InsertRear(Cars, theItem, Worked);
               if Worked = True then
                  Put("Input Successful"); New_Line;
               else
                  Put("Input Failed"); New_Line;
                  end if;
            end if;
         elsif OperationType = Delete then
           --Find First
            --Delete Operation
            Put("Enter what you want to search by: "); Get(Searchtype); New_Line;
            if Searchtype = Maker then
               Put("Enter Maker: "); Get(theItem.ItemMake);
            elsif Searchtype = Doors then
               Put("Enter number of doors: "); Get(theItem.NumDoors);
            else
               raise Data_Error with "Cars only have one engine";
            end if;

            Found := False;
            currPT := Cars;
            TempListPT := findItem(Cars, temp);
            While Found = False loop
               case Searchtype is
                  when Maker =>
                     if temp.ItemMake = theItem.ItemMake then
                        Found := True;
                     end if;
                     when Doors =>
                        if temp.NumDoors = theItem.NumDoors then
                           Found := True;
                        end if;
                     when Engine =>
                        if temp.NumEngines = theItem.NumEngines then
                           Found := True;
                        end if;
               end case;
               if found = False then
                  currPT := TempListPT;
                  TempListPT := findItem(TempListPT, temp);
               end if;
            end loop;
            Delete(Cars, currPT);
            TempListPT := null;
         elsif OperationType = Print then
            --Print List
            Knt := listSize(Cars);
            TempListPT := null;
            TempListPT := findItem(Cars, temp);
            while Knt /= 0 loop
               Put("Make is "); Put(temp.ItemMake); New_Line;
               Put("Number of Doors is "); Put(temp.NumDoors); New_Line(2);
               Knt := Knt -1;
               if Knt > 0 then
                  TempListPT := findItem(TempListPT, temp);
                  end if;
           end loop;
         else
         Put(ListSize(Cars)); New_Line;
         end if;
      else
         exit;
      end if;
   end loop;

   null;
end Bags;
