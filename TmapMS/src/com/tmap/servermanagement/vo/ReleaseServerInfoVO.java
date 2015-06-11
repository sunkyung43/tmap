/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.servermanagement.vo;

import com.tmap.common.PaginationVO;

public class ReleaseServerInfoVO extends PaginationVO{

		private String interfaceSetState;
		private String interfaceRmState;

		
		/** 
		 * @return the interfaceRmState 
		 */
		
		public String getInterfaceRmState() {
			return interfaceRmState;
		}

		/** 
		 * @param interfaceRmState the interfaceRmState to set 
		 */
		public void setInterfaceRmState(String interfaceRmState) {
			this.interfaceRmState = interfaceRmState;
		}

		/** 
		 * @return the interfaceSetState 
		 */
		
		public String getInterfaceSetState() {
			return interfaceSetState;
		}

		/** 
		 * @param interfaceSetState the interfaceSetState to set 
		 */
		public void setInterfaceSetState(String interfaceSetState) {
			this.interfaceSetState = interfaceSetState;
		}
		
		
}
