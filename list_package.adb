with Ada.Unchecked_Deallocation;
package body List_Package is

   procedure free is new ada.Unchecked_Deallocation(List_Package_Node, List_Package_NodePT);

   -----------------
   -- InsertFront --
   -----------------

   procedure InsertFront
     (list : in out List_Package_NodePT;
      Data : in ItemsType;
      Success : out Boolean)
   is
      temp : List_Package_NodePT;
   begin
      if list = null then
         list := new List_Package_Node'(NodeInfo => Data,
                                        RLink    => null,
                                        LLink    => null);
         if list = null then
               Success := False;
            end if;
            Success := True;
         else
            temp := new List_Package_Node'(NodeInfo => Data,
                                           RLink    => list,
                                           LLink    => null);
         if temp.RLink = null then
            Success := False;
         end if;
         Success := True;
         list.LLink := temp;
         list := temp;
         end if;
   end InsertFront;

   ----------------
   -- InsertRear --
   ----------------

   procedure InsertRear
     (list : in out List_Package_NodePT;
      Data : in ItemsType;
      Success : out Boolean)
   is
      temp : List_Package_NodePT;
   begin
      if list = null then
         list := new List_Package_Node'(NodeInfo => Data,
                                        RLink    => null,
                                        LLink    => null);
         if list = null then
               Success := False;
            end if;
            Success := True;
      else
         temp := list;
         while temp.RLink /= null loop
            temp := temp.RLink;
         end loop;

         temp.RLink := new List_Package_Node'(NodeInfo => Data,
                                              RLink    => null,
                                              LLink    => temp);
            if temp.RLink = null then
               Success := False;
            end if;
            Success := True;
      end if;

   end InsertRear;

   --------------
   -- listSize --
   --------------

   function listSize (list : in List_Package_NodePT) return Integer is
      Cnt : Integer := 0;
      temp: List_Package_NodePT := list;
   begin
      while temp /= null loop
         Cnt := Cnt + 1;
         temp := temp.RLink;
      end loop;
      return Cnt;
   end listSize;

   --------------
   -- findItem --
   --------------

   function findItem
     (list : in List_Package_NodePT;
      Data : out ItemsType)
      return List_Package_NodePT
   is
      temp : List_Package_NodePT;
   begin
      if list.LLink = null then
         temp := list;
         Data := temp.NodeInfo;
         temp := temp.RLink;
      else
         temp := list;
         Data := temp.NodeInfo;
         temp := temp.RLink;
      end if;
      return temp;
   end findItem;

   ------------
   -- Delete --
   ------------

   procedure Delete
     (list : in out List_Package_NodePT;
      PT : List_Package_NodePT)
   is
      temp : List_Package_NodePT := list;
      DataPT: List_Package_NodePT := PT;
   begin
      if DataPT = temp then
         temp := temp.RLink;
         list := temp;
         free(DataPT);
      elsif PT.RLink /= null and PT.LLink /= null then
         temp := PT.LLink;
         DataPT := PT.RLink;
         temp.RLink := DataPT;
         DataPT := PT;
         free(DataPT);
      else
         DataPT := DataPT.LLink;
         DataPT.RLink := null;
         DataPT := PT;
         free(DataPT);
      end if;
   end Delete;

end List_Package;
